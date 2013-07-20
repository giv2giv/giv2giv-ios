//
//  Charity.h
//  Giv2Giv-New
//
//  Created by David Hadwin on 11/17/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Charity : NSObject

@property (nonatomic, strong) NSString *charityID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *mission;
@property (nonatomic) float percentage;

- (id)initWithName:(NSString *)name andID:(NSString *)charID andMission:(NSString *)mission;
- (Charity *)copyCharity;
@end
