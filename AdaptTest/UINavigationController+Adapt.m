//
//  UINavigationController+Adapt.m
//  AdaptTest
//
//  Created by sunlight on 14-5-9.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "UINavigationController+Adapt.h"

@implementation UINavigationController (Adapt)
// These methods control the attributes of the status bar when this view controller is shown. They can be overridden in view controller subclasses to return the desired status bar attributes.
- (UIStatusBarStyle)preferredStatusBarStyle NS_AVAILABLE_IOS(7_0){

    return UIStatusBarStyleLightContent;
} // Defaults to UIStatusBarStyleDefault
- (BOOL)prefersStatusBarHidden NS_AVAILABLE_IOS(7_0){

    return NO;
}
@end