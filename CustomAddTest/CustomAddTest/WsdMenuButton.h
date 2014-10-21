//
//  WsdMenuButton.h
//  CustomAddTest
//
//  Created by sunlight on 14-5-13.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//
#define kMenuButtonHeight 100.0f
#define kDeleteButtonHeight 20.0f
#define kMenuButtonWidth 200.0f
#define kDeleteButtonWidth 20.0f

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class WsdMenuButton;
@protocol WsdMenuButtonDelegate <NSObject>

//点击删除小按钮后调用
- (void)clickLittleDeleteButton:(WsdMenuButton *) wsdMenuButton;
//长按按钮后调用
- (void)longPressMenuButton;

@end



@interface WsdMenuButton : UIButton

@property (nonatomic,weak) id<WsdMenuButtonDelegate> delegate;
@property (nonatomic,strong) UIButton *deleteButton;

+ (id)wsdMenuButtonWithType:(UIButtonType)buttonType HasRemoveButton:(BOOL)hasRemoveButton;

@end
