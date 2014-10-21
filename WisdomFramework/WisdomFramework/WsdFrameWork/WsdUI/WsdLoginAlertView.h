//
//  WsdLoginAlertView.h
//  SupplierQuestionnaire
//
//  Created by sunlight on 14-6-13.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WsdBaseView.h"
@class WsdLoginAlertView;
@protocol WsdAlertViewDelegate <NSObject>

- (void)clickButtonAtIndex:(NSInteger)buttonIndex wsdAlertView:(WsdLoginAlertView *)loginAlertView;
//接触背景View delegate
- (void)touchBackgroundView:(WsdLoginAlertView *)wsdLoginAlertView;

@end

@interface WsdLoginAlertView : WsdBaseView

@property (nonatomic,weak) id<WsdAlertViewDelegate> delegate;
@property (nonatomic,strong) UITextField *userNameTextField;
@property (nonatomic,strong) UITextField *passwordTextField;
- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<WsdAlertViewDelegate>*/)delegate buttonTitles:(NSString *)buttonTitles, ...NS_REQUIRES_NIL_TERMINATION;

- (void)showAlertView;
- (void)disShowAlertView;

@end
