//
//  FirstViewController.m
//  Giv2Giv
//
//  Created by David Hadwin on 8/23/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import "CharitiesViewController.h"
#import "CharityDetailViewController.h"
#import "LoginViewController.h"
#import "Dashboard.h"
#import "Connection.h"
#import "Charity.h"

@interface CharitiesViewController ()

@end

@implementation CharitiesViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    charities = [[NSMutableArray alloc] init];
    Connection *signUpConnection = [[Connection alloc] init];
    [signUpConnection set_url:@"http://www.giv2giv.org/api/charity_group.json"];
    NSArray *returnedInfo = [signUpConnection responseFromServer];
    
    NSLog(@"Response from donors:%@",returnedInfo);
    for (NSDictionary *dict in returnedInfo) {
        Charity* newCharity = [[Charity alloc] initWithName:[dict objectForKey:@"name"] andID:[dict objectForKey:@"id"] andMission:[dict objectForKey:@"mission"]];
        [charities addObject:newCharity];
    }
    NSLog(@"Charities:\n%@", charities);
    searchResults = [[NSMutableArray alloc] init];

    //Ask server for list of charities - CHECK
    
    self.navigationItem.title = @"Charities";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //Setup searchbar
    self.searchDisplayController.delegate = self;
    self.searchDisplayController.searchBar.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated {

}

- (IBAction)unwindFromPickingCharity:(UIStoryboardSegue *)segue {
    
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"1");
    selectedCharity = [[charities objectAtIndex:[indexPath row]] copyCharity];
    [self performSegueWithIdentifier:@"Detail Segue" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"2");
    CharityDetailViewController *cdvc = segue.destinationViewController;
    //selectedCharity = [sender title];
    NSLog(@"SelectedCharity:%@", selectedCharity);
    [cdvc setCharity:selectedCharity];
}

//---SEARCHBAR FUNCTIONS----
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [searchResults removeAllObjects];
    
    if ([searchText length] != 0) {
        for (int i = 0; i<[charities count]; i++) {
            NSRange titleResultsRange = [[charities objectAtIndex:i]rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (titleResultsRange.length != 0) {
                [searchResults addObject:[charities objectAtIndex:i]];
            }
        }
    }
}

//---TABLEVIEW FUNCTIONS-----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
    } else {
        return [charities count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [[NSString alloc] init];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        text = [[searchResults objectAtIndex:[indexPath row]] name];
    } else {
        text = [[charities objectAtIndex:[indexPath row]] name];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Charity Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Charity Cell"];
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    cell.textLabel.text = text;
    
    return cell;
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

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
