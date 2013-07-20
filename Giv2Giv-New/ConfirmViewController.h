//
//  ConfirmViewController.h
//  Giv2Giv-New
//
//  Created by David Hadwin on 9/8/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmViewController : UIViewController
@property (weak, nonatomic) NSString *firstName;
@property (weak, nonatomic) NSString *lastName;
@property (weak, nonatomic) NSString *dateOfBirth;
@property (weak, nonatomic) NSString *address;
@property (weak, nonatomic) NSString *city;
@property (weak, nonatomic) NSString *state;
@property (weak, nonatomic) NSString *zipCode;
@property (weak, nonatomic) NSString *phoneNumber;
@property (weak, nonatomic) NSString *email;

@property (weak, nonatomic) IBOutlet UILabel *firstNameField;
@property (weak, nonatomic) IBOutlet UILabel *lastNameField;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthField;
@property (weak, nonatomic) IBOutlet UILabel *addressField;
@property (weak, nonatomic) IBOutlet UILabel *cityField;
@property (weak, nonatomic) IBOutlet UILabel *stateField;
@property (weak, nonatomic) IBOutlet UILabel *zipCodeField;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberField;
@property (weak, nonatomic) IBOutlet UILabel *emailField;
- (IBAction)cancel:(id)sender;
- (IBAction)confirm:(id)sender;

@end
