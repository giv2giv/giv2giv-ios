//
//  ViewController.h
//  Giv2Giv-New
//
//  Created by David Hadwin on 9/8/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardViewController : UITableViewController
{
    NSMutableSet *sliders;
    NSMutableDictionary *oldSliders;
}
- (IBAction)sliderchanged:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)lockSlider:(id)sender;
- (IBAction)logOut:(id)sender;
- (IBAction)unwindFromTermsAndServices:(UIStoryboardSegue *)segue;
@end
