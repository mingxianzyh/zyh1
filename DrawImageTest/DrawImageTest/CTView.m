//
//  CTView.m
//  DrawImageTest
//
//  Created by sunlight on 14-8-6.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "CTView.h"

@implementation CTView

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
    CGContextSaveGState(context);
    //CGContextSetFillColorWithColor(context, [[UIColor cyanColor] CGColor]);
    CGContextSetStrokeColorWithColor(context, [[UIColor cyanColor] CGColor]);
    UIRectFrame(CGRectMake(10, 20, 100, 100));
    
    CGContextRestoreGState(context);
    CGContextMoveToPoint(context, 100, 100);
    CGContextAddLineToPoint(context, 200, 200);
    CGContextStrokePath(context);
    
    CGContextAddEllipseInRect(context, CGRectMake(100, 100, 30, 30));
    CGContextDrawPath(context, kCGPathStroke);
    
    [@"1" drawAtPoint:CGPointMake(30, 30) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
}


@end
