//
//  CharityDetailViewController.m
//  Giv2Giv-New
//
//  Created by David Hadwin on 10/11/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import "CharityDetailViewController.h"
#import "Dashboard.h"

@interface CharityDetailViewController ()

@end

@implementation CharityDetailViewController
@synthesize charity;
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationItem setTitle:[charity name]];
    _textBox.text = [charity mission];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addCharity:(id)sender {
    NSLog(@"Adding %@", charity);
    [[Dashboard defaultDashboard] addACharity:charity];
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)viewDidUnload {
    [self setTextBox:nil];
    [super viewDidUnload];
}
@end
