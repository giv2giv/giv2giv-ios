//
//  SignUpViewController.m
//  Giv2Giv-New
//
//  Created by David Hadwin on 9/8/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import "SignUpViewController.h"
#import "ConfirmViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize scrollView;
@synthesize firstNameField;
@synthesize lastNameField;
@synthesize yearField;
@synthesize dayField;
@synthesize monthField;
@synthesize addressField;
@synthesize cityField;
@synthesize stateField;
@synthesize zipCodeField;
@synthesize numberField;
@synthesize emailField;
@synthesize passwordField;
@synthesize verifyPasswordField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView.delegate = self;
	[scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 800)];
    
    [firstNameField setDelegate:self];
    [lastNameField setDelegate:self];
    [yearField setDelegate:self];
    [dayField setDelegate:self];
    [monthField setDelegate:self];
    [addressField setDelegate:self];
    [cityField setDelegate:self];
    [stateField setDelegate:self];
    [zipCodeField setDelegate:self];
    [numberField setDelegate:self];
    [emailField setDelegate:self];
    [passwordField setDelegate:self];
    [verifyPasswordField setDelegate:self];
}

- (void)checkInfo {
    //Check sign up information
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)validateInfo:(id)sender {
    [self performSegueWithIdentifier:@"Confirm Segue" sender:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return TRUE;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ConfirmViewController *cvc = segue.destinationViewController;
    [cvc setFirstName:[firstNameField text]];
    [cvc setLastName:[lastNameField text]];
    [cvc setDateOfBirth:[NSString stringWithFormat:@"%@/%@/%@", monthField.text,dayField.text,yearField.text]];
    [cvc setAddress:[addressField text]];
    [cvc setCity:[cityField text]];
    [cvc setState:[stateField text]];
    [cvc setZipCode:[zipCodeField text]];
    [cvc setPhoneNumber:[numberField text]];
    [cvc setEmail:[emailField text]];
    NSLog(@"DID IT!");
}
@end
