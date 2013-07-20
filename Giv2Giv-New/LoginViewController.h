//
//  LoginViewController.h
//  Giv2Giv
//
//  Created by David Hadwin on 8/23/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
{
}

@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;

- (BOOL)verifyToken;

@end
