//
//  UIColor+randomColor.m
//  Quartz
//
//  Created by sunlight on 14-4-25.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "UIColor+randomColor.h"

@implementation UIColor (randomColor)

+ (UIColor *)randomColor{
    
    NSInteger redColor = arc4random()%255;
    NSInteger greenColor = arc4random()%255;
    NSInteger blueColor = arc4random()%255;
    return [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:1.0];
}

@end
