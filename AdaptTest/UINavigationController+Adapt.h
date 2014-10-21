//
//  UINavigationController+Adapt.h
//  AdaptTest
//
//  Created by sunlight on 14-5-9.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Adapt)

// These methods control the attributes of the status bar when this view controller is shown. They can be overridden in view controller subclasses to return the desired status bar attributes.
- (UIStatusBarStyle)preferredStatusBarStyle NS_AVAILABLE_IOS(7_0); // Defaults to UIStatusBarStyleDefault
- (BOOL)prefersStatusBarHidden NS_AVAILABLE_IOS(7_0); // Defaults to NO
// Override to return the type of animation that should be used for status bar changes for this view controller. This currently only affects changes to prefersStatusBarHidden.

@end
