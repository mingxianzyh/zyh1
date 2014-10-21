//
//  YDView.m
//  YDReader
//
//  Created by sunlight on 14-10-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "YDView.h"

@implementation YDView

-(instancetype)initWithFrame:(CGRect)frame gradientLayer:(CAGradientLayer *)gradientLayer{

    self = [super initWithFrame:frame];
    if (self) {
        _gradientLayer = gradientLayer;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)setGradientLayer:(CAGradientLayer *)gradientLayer{
    [_gradientLayer removeFromSuperlayer];
    _gradientLayer = gradientLayer;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_gradientLayer) {
        _gradientLayer.frame = self.bounds;
        [self.layer insertSublayer:_gradientLayer atIndex:0];
    }
}


@end
