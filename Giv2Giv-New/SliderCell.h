//
//  SliderCell.h
//  Giv2Giv
//
//  Created by David Hadwin on 8/23/12.
//  Copyright (c) 2012 Giv2Giv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UILabel *percentage;
@property (weak, nonatomic) IBOutlet UIButton *lock;
@property (nonatomic, strong) IBOutlet UISlider *slider;
@end
