//
//  TermsAndServicesViewController.m
//  Giv2Giv-New
//
//  Created by David Hadwin on 10/10/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import "TermsAndServicesViewController.h"

@interface TermsAndServicesViewController ()

@end

@implementation TermsAndServicesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)acceptTermsAndServices {
    
    return true;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)agree:(id)sender {
    //[self unwindFromTermsAndServices:<#(UIStoryboardSegue *)#>]
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
