//
//  SliderInfo.m
//  Giv2Giv-New
//
//  Created by David Hadwin on 10/17/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import "SliderInfo.h"

@implementation SliderInfo
@synthesize tag;
@synthesize oldValue;

-(SliderInfo *)initSliderInfoWithTag:(NSInteger)t andValue:(float)value {
    [self setOldValue:value];
    [self setTag:t];
    
    return self;
}
@end
