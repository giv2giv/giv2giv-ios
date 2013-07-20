//
//  SliderInfo.h
//  Giv2Giv-New
//
//  Created by David Hadwin on 10/17/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SliderInfo : NSObject
@property float oldValue;
@property NSInteger tag;

- (SliderInfo *)initSliderInfoWithTag:(NSInteger)tag andValue:(float)value;
@end
