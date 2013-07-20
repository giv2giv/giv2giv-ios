//
//  Dashboard.h
//  Giv2Giv-New
//
//  Created by David Hadwin on 9/8/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Charity.h"
@interface Dashboard : NSObject
{
    float funds;
    float principalPercent;
    float earningsPercent;
    NSMutableArray *charities;
}
+ (Dashboard *)defaultDashboard;

@property (nonatomic) float funds;
@property (nonatomic) float principalPercent;
@property (nonatomic) float earningsPercent;

- (NSMutableArray *)charities;
- (void)addACharity:(Charity *)name;

@end
