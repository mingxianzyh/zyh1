//
//  TouchView.m
//  TouchView
//
//  Created by sunlight on 14-3-20.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 50, 50)];
        _moveView.backgroundColor=[UIColor grayColor];
        [self addSubview:_moveView];
        //单击
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapScreen:)];        
        //双击
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapScreen:)];
        
        doubleTap.numberOfTapsRequired = 2;
        //设置双击事件的时候不影响单击事件
        [tap requireGestureRecognizerToFail:doubleTap];
        [self addGestureRecognizer:tap];
        [self addGestureRecognizer:doubleTap];
        
        //轻扫-left
        UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeLeftGesture];
        
        
        //轻扫-right
        UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
        swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeRightGesture];
        
        //轻扫-up
        UISwipeGestureRecognizer *swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
        swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipeUpGesture];
        
        //轻扫-down
        UISwipeGestureRecognizer *swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
        swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:swipeDownGesture];
        
        
        [swipeLeftGesture release];
        [swipeRightGesture release];
        [swipeUpGesture release];
        [swipeDownGesture release];
        [tap release];
        [doubleTap release];
    }
    return self;
}

- (void) singleTapScreen:(UITapGestureRecognizer*)tapGuest{
    
    NSLog(@"单击");
}

- (void) doubleTapScreen:(UITapGestureRecognizer*)tapGuest{
    
    NSLog(@"双击");
}
- (void) swipeLeft:(UISwipeGestureRecognizer*)swipeGuest{
    
    self.backgroundColor = [UIColor greenColor];
}

- (void) swipeRight:(UISwipeGestureRecognizer*)swipeGuest{
    
    self.backgroundColor = [UIColor grayColor];
}


- (void) swipeUp:(UISwipeGestureRecognizer*)swipeGuest{
    
    self.backgroundColor = [UIColor cyanColor];
}


- (void) swipeDown:(UISwipeGestureRecognizer*)swipeGuest{
    
    self.backgroundColor = [UIColor orangeColor];
}


//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//    CGPoint nowPoint = [touch locationInView:self];
//    CGRect frame = _moveView.frame;
//    frame.origin = CGPointMake(nowPoint.x - frame.size.width/2, nowPoint.y - frame.size.height/2);
//    _moveView.frame = frame;
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//    CGPoint nowPoint = [touch locationInView:self];
//    CGRect frame = _moveView.frame;
//    frame.origin = CGPointMake(nowPoint.x - frame.size.width/2, nowPoint.y - frame.size.height/2);
//    _moveView.frame = frame;
//    
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchEnded");
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchCancelled");
//}

- (void)dealloc{
    [_moveView release];
    [super dealloc];
}
@end
