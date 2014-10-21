//
//  QuartzView.m
//  Quartz
//
//  Created by sunlight on 14-4-27.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "QuartzView.h"

@implementation QuartzView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextMoveToPoint(context, 20, 50);
    CGContextAddLineToPoint(context, 100, 200);
    CGContextStrokePath(context);
}


@end
