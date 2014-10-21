//
//  RootViewController.h
//  First
//
//  Created by sunlight on 14-3-4.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StringTool.h"
#import "ToolBarViewController.h"
@interface LoginViewController: UIViewController <UIActionSheetDelegate>

@property (retain,nonatomic) IBOutlet UITextField *nameTextField;
@property (retain,nonatomic) IBOutlet UITextField *passwordTextField;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *pwdLabel;
@property (retain, nonatomic) IBOutlet UIButton *submitButton;
@property (retain, nonatomic) IBOutlet UIButton *resetButton;
@property (retain,nonatomic) ToolBarViewController *toolBarViewController;

- (IBAction)submit:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)textFieldDoneEdit:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
