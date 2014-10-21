//
//  UIView+Extend.m
//  CustomAddTest
//
//  Created by sunlight on 14-5-14.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "UIView+Extend.h"

@implementation UIView (Extend)
//获取当前View所在的视图控制器
- (UIViewController *)viewController{
    
    UIResponder *responder = [self nextResponder];
    if (responder!=nil && [responder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)responder;
    }
    //循环获取父视图
    for (UIView *view = [self superview]; view; view = [view superview]) {
        responder = [view nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

@end
