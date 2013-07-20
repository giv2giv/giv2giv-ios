//
//  ConfirmViewController.m
//  Giv2Giv-New
//
//  Created by David Hadwin on 9/8/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import "ConfirmViewController.h"
#import "Connection.h"

@interface ConfirmViewController ()

@end

@implementation ConfirmViewController
@synthesize firstName;
@synthesize lastName;
@synthesize dateOfBirth;
@synthesize address;
@synthesize city;
@synthesize state;
@synthesize zipCode;
@synthesize phoneNumber;
@synthesize email;
@synthesize firstNameField;
@synthesize lastNameField;
@synthesize dateOfBirthField;
@synthesize addressField;
@synthesize cityField;
@synthesize stateField;
@synthesize zipCodeField;
@synthesize phoneNumberField;
@synthesize emailField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    firstNameField.text = firstName;
    lastNameField.text = lastName;
    dateOfBirthField.text = dateOfBirth;
    addressField.text = address;
    cityField.text = city;
    stateField.text = state;
    zipCodeField.text = zipCode;
    phoneNumberField.text = phoneNumber;
    emailField.text = email;
}

- (BOOL)sendInformationForConfirmation {
    Connection *signUpConnection = [[Connection alloc] init];
    [signUpConnection set_url:@"http://www.giv2giv.org/api/donors.json"];
    
    NSArray *keys = [NSArray arrayWithObjects:@"email", @"password", @"name", nil];
    //REMEMBER TO FIX PASSWORD FIELD!!!!!!!_!_!_!_!_!_!_!
    NSArray *objects = [NSArray arrayWithObjects:email, lastName, firstName, nil];
    NSDictionary *response = [signUpConnection responseFromServerJSON:objects andKeys:keys];
    NSLog(@"Response from donors:%@",response);
    
    return true;
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

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirm:(id)sender {
    BOOL goodToGo;
    goodToGo = [self sendInformationForConfirmation];
    if (goodToGo) {
        [self performSegueWithIdentifier:@"Terms" sender:nil];
    } else {
        NSLog(@"BADBADBADBAD" );
    }
}

- (void)viewDidUnload {
    [self setFirstName:nil];
    [self setLastName:nil];
    [self setDateOfBirth:nil];
    [self setAddress:nil];
    [self setCity:nil];
    [self setState:nil];
    [self setZipCode:nil];
    [self setPhoneNumber:nil];
    [self setEmail:nil];
    [super viewDidUnload];
}
@end
