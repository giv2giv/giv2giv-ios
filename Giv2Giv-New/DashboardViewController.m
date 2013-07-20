#import "DashboardViewController.h"
#import "Dashboard.h"
#import "SliderCell.h"
#import "InfoCell.h"
#import "SliderInfo.h"
#import "Connection.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    sliders = [[NSMutableSet alloc] init];
    oldSliders = [[NSMutableDictionary alloc] init];
    
    //Load info for dashboard
    self.navigationItem.title = @"Dashboard";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"Test");
    //Changes linkDone back to false for TESTING
    //[[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"linkDone"];
    //-------------------------------------------------------------------------------------
    BOOL linkDone = [[NSUserDefaults standardUserDefaults] boolForKey:@"linkDone"];
    NSLog(@"linkDone = %d", linkDone);
    if (!linkDone) {
        NSLog(@"login should come up");
        [self performSegueWithIdentifier:@"Login Segue" sender:self];
    }
}

//Load info
//Save info

-(void)save:(id)sender {
    
}

- (IBAction)sliderchanged:(id)sender {
    UISlider *currentSlider = sender;
    NSInteger tag = currentSlider.tag;
    NSInteger lockCounter = 0;
    float lockValue = 0;
    
    for (SliderCell *cell in sliders) {
        if (![[cell slider] isEnabled]) {
            lockCounter++;
            lockValue += [[cell slider] value];
        }
    }
    
    float value = currentSlider.value;
    NSLog(@"Slider value:%04.02f", value);
    float otherValue = (100 - (value + lockValue))/(sliders.count - lockCounter - 1);
    if (value > (100 - lockValue)) {
        value = 100 - lockValue;
        otherValue = 0.00f;
    } else if (((value + lockValue) < 100) && lockCounter == sliders.count -1) {
        NSLog(@"All But One Are LOCKED");
        value = 100 - lockValue;
    } else if ((value + lockValue + (otherValue * (sliders.count - lockCounter - 1))) > 100) {
        value = 100 - lockValue;
        otherValue = 0.00f;
    }
    NSLog(@"Value NOW: %04.02f", value);
    NSLog(@"OtherValue NOW: %04.02f", otherValue);
    for (SliderCell *cell in sliders) {
        if (cell.slider.tag != tag && cell.slider.isEnabled) {
            [[cell slider] setValue:otherValue];
            [[cell percentage] setText:[NSString stringWithFormat:@"%04.02f%%", otherValue]];
        } else if (cell.slider.tag == tag && cell.slider.isEnabled) {
            [[cell slider] setValue:value];
            [[cell percentage] setText:[NSString stringWithFormat:@"%04.02f%%", value]];
        }
    }
}

- (IBAction)lockSlider:(id)sender {
    SliderCell *cell;
    UIButton *button = sender;
    for (SliderCell *temptCell in sliders) {
        if ([[temptCell slider] tag] == [sender tag]) {
            cell = temptCell;
        }
    }
    if ([[[button titleLabel] text] isEqualToString:@"Lock"]) {
        [[cell slider] setEnabled:FALSE];
        [button setTitle:@"Unlock" forState:UIControlStateNormal];
    } else {
        [[cell slider] setEnabled:TRUE];
        [button setTitle:@"Lock" forState:UIControlStateNormal];
    }
}

- (IBAction)logOut:(id)sender {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_token"];
    //Connect to server to verify token
    Connection *loginConnection = [[Connection alloc] init];
    [loginConnection set_url:@"http://www.giv2giv.org/api/sessions/create.json"];
    
    NSArray *keys = [NSArray arrayWithObjects:nil];
    //REMEMBER TO FIX PASSWORD FIELD!!!!!!!_!_!_!_!_!_!_!
    NSArray *objects = [NSArray arrayWithObjects:nil];
    
    NSDictionary *variablesDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    //NSDictionary *jsonDict = [NSDictionary dictionaryWithObject:questionDict forKey:@"question"];
    
    NSData *jsonRequest = [NSJSONSerialization dataWithJSONObject:variablesDict options:nil error:nil];
    
    NSLog(@"jsonRequest is %@", jsonRequest);
    
    NSURL *url = [NSURL URLWithString:@"http://www.giv2giv.org/api/sessions/destroy.json"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    //NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    [request setHTTPMethod:@"POST"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonRequest length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:[NSString stringWithFormat:@"Token token=%@", token] forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody: jsonRequest];
    
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //[connection start]; //Use for asynchronous calls
    
    id json;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (receivedData) {
        json = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:nil];
    } else {
        NSLog(@"Error");
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"linkDone"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"session_token"];
    [self viewDidAppear:TRUE];
}

- (IBAction)unwindFromTermsAndServices:(UIStoryboardSegue *)segue {
    [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"linkDone"];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark TABLE VIEW FUNCTIONS

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        case 2:
            //Change 2 to a 4 if Principal/Earnings/-to- cell's need to be added
            return 1 + [[[Dashboard defaultDashboard] charities] count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Fund";
            break;
        case 1:
            return @"Invest";
            break;
        case 2:
            return @"Donate";
            break;
        case 3:
            return @"";
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section]) {
        case 0:{
            switch ([indexPath row]) {
                case 0:
                    return 44;
                    break;
                case 1:
                    return 44;
                    break;
                default:
                    break;
            }
            break;
        }
        case 1:{
            return 44;
            break;
        }
        case 2:{
            switch ([indexPath row]) {
                case 0: {
                    return 40;
                }
//Enable for From Principle Slider, From Earnings Slider, and -to- cell
//                case 1:{
//                    return 30;
//                    break;
//                }
//                case 2: {
//                    return 30;
//                    break;
//                }
//                case 3: {
//                    return 30;
//                    break;
//                }
                default: {
                    return 70;
                    break;
                }
            }
            break;
        }
        case 3:
            return 50;
            break;
        default:
            return 44;
            break;
    }
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %d Row: %d", [indexPath section], [indexPath row]);
    switch ([indexPath section]) {
        case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCell"];
            }
            switch ([indexPath row]) {
                case 0:
                    [[cell textLabel] setText:@"Current Funds:"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"$%04.02f",[[Dashboard defaultDashboard] funds]]];
                    return cell;
                    break;
                case 1:
                    [[cell textLabel] setText:@"Schedule:"];
                    [[cell detailTextLabel] setText:@"$7/week"];
                    return cell;
                    break;
                default:
                    break;
            }
            break;
        }
        case 1:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCell"];
            }
            [[cell textLabel] setText:@"Balanced Mutual Fund:"];
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"$%04.02f",[[Dashboard defaultDashboard] funds]]];
            return cell;
            break;
        }
        case 2:{
            switch ([indexPath row]) {
                case 0:{
                    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
                    if (!cell) {
                        cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoCell"];
                    }
                    [[cell infoLabel] setText:@"Every 90 days donate 5% of your fund to..."];
                    return cell;
                    break;
                }
//Enable for From Principle Slider, From Earnings Slider, and -to- cell
//                case 1:{
//                    SliderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DonateCell"];
//                    if (!cell) {
//                        cell = [[SliderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DonateCell"];
//                    }
//                    [[cell label] setText:@"From principal"];
//                    [[cell percentage] setText:[NSString stringWithFormat:@"$%04.02f", [[Dashboard defaultDashboard] principalPercent]* [[Dashboard defaultDashboard] funds]]];
//                    [[cell slider] setMinimumValue:0];
//                    [[cell slider] setMaximumValue:[[Dashboard defaultDashboard] funds] * .75];
//                    [[cell slider] setValue:[[Dashboard defaultDashboard] principalPercent]];
//                    return cell;
//                    break;
//                }
//                case 2:{
//                    SliderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DonateCell"];
//                    if (!cell) {
//                        cell = [[SliderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DonateCell"];
//                    }
//                    [[cell label] setText:@"From earnings"];
//                    [[cell percentage] setText:[NSString stringWithFormat:@"%04.02f%%", [[Dashboard defaultDashboard] earningsPercent]]];
//                    [[cell slider] setMinimumValue:0];
//                    [[cell slider] setMaximumValue:100];
//                    [[cell slider] setValue:[[Dashboard defaultDashboard] earningsPercent]];
//                    return cell;
//                    break;
//                }
//                case 3: {
//                    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
//                    if (!cell) {
//                        cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoCell"];
//                    }
//                    [[cell infoLabel] setText:@"- to -"];
//                    return cell;
//                    break;
//                }
                default: {
                    SliderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SliderCell"];
                    if (!cell) {
                        cell = [[SliderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SliderCell"];
                    }
                    //Change -1 to -4 to put Principal/Earnings/-to- cells back
                    Charity *charity = [[[Dashboard defaultDashboard] charities] objectAtIndex:[indexPath row] - 1];
                    NSLog(@"Charity: %@", [charity name]);
                    [[cell label] setText:[charity name]];
                    [[cell percentage] setText:[NSString stringWithFormat:@"%04.02f%%", [charity percentage]]];
                    [[cell slider] setMinimumValue:0];
                    [[cell slider] setMaximumValue:100];
                    [[cell slider] setValue:[charity percentage]];
                    NSInteger tag = [indexPath row] - 1;
                    [[cell slider] setTag:tag];
                    [[cell lock] setTag:tag];
                    [sliders addObject:cell];
                    return cell;
                    break;
                }
            }
            break;
        }
        default:
            return nil;
            break;
    }
    return nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

