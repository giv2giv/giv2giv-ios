//
//  Dashboard.m
//  Giv2Giv-New
//
//  Created by David Hadwin on 9/8/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import "Dashboard.h"
#import "Charity.h"

static Dashboard *defaultDashboard = nil;

@implementation Dashboard
@synthesize funds, principalPercent, earningsPercent;

+ (id)alloc {
    return [self defaultDashboard];
}

+ (Dashboard *)defaultDashboard {
    if (!defaultDashboard) {
        defaultDashboard = [[super alloc] init];
    }
    return defaultDashboard;
}

- (id)init {
    if  (defaultDashboard) {
        return defaultDashboard;
    }
    self = [super init];
    if (self) {
        funds = 0.00;
        principalPercent = 0.00;
        earningsPercent = 0.00;
        charities = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSMutableArray *)charities {
    return charities;
}

- (void)addACharity:(Charity *)theCharity {
    [charities addObject:theCharity];
}

@end
