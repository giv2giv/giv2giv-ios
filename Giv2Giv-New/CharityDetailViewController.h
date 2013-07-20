//
//  CharityDetailViewController.h
//  Giv2Giv-New
//
//  Created by David Hadwin on 10/11/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Charity.h"

@interface CharityDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textBox;
@property (strong, nonatomic) Charity *charity;
- (IBAction)addCharity:(id)sender;

@end
