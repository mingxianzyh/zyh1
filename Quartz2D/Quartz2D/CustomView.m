//
//  CustomView.m
//  Quartz2D
//
//  Created by sunlight on 14-10-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    drawLine();
    drawArc();
    
    
}

void drawLine(){
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 20.0, 100.0);
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width-20.0, 100.0);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 20.0);
    CGFloat pattern[] = {5,5};
    CGContextSetLineDash(context, 0, pattern, 2);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}
void drawArc(){
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextRestoreGState(context);
    CGContextBeginPath(context);
    //CGContextMoveToPoint(context, 20.0, 200.0);
    CGContextAddArc(context, 20.0, 200.0, 30, 20, 20, 5);
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width-20.0, 200.0);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

@end
