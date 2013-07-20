//
//  LoginViewController.m
//  Giv2Giv
//
//  Created by David Hadwin on 8/23/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import "LoginViewController.h"
#import "Connection.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize username, password;

- (BOOL)verifyToken {
    BOOL valid;
    //Connect to server to verify token
    Connection *loginConnection = [[Connection alloc] init];
    [loginConnection set_url:@"http://www.giv2giv.org/api/sessions/create.json"];
    
    NSArray *keys = [NSArray arrayWithObjects:@"email", @"password", nil];
    //REMEMBER TO FIX PASSWORD FIELD!!!!!!!_!_!_!_!_!_!_!
    NSArray *objects = [NSArray arrayWithObjects:username.text, password.text, nil];
    
    //Server returns an ID
    NSDictionary *response = [loginConnection responseFromServerJSON:objects andKeys:keys];
    NSLog(@"Response from donors:%@",response);
    
    //Store ID
    if (response) { //Check if username and password are valid
        NSString *token = [response objectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"linkDone"];
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"session_token"];
        valid = TRUE;
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSLog(@"Invalid");
        valid = FALSE;
    }
    return valid;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [username setDelegate:self];
    [password setDelegate:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //Action of return button
    [self verifyToken];
    [textField resignFirstResponder];
    return TRUE;
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

@end
