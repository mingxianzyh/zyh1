//
//  BaseViewController.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-15.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

//所有导航内容控制器的父类，默认会再左上角加上一个显示popoverController的按钮
@interface BaseViewController : UIViewController

- (void)showPopoverView;

@end
