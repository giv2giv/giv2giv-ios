//
//  FirstViewController.h
//  Giv2Giv
//
//  Created by David Hadwin on 8/23/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Charity.h"

@interface CharitiesViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate> {
    NSMutableArray *charities;
    NSMutableArray *searchResults;
    Charity *selectedCharity;
}
- (IBAction)cancel:(id)sender;


@end
