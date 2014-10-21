//
//  RootViewController.m
//  First
//
//  Created by sunlight on 14-3-4.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "LoginViewController.h"
#import "NSString+Tool.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //获取刚进入屏幕时的方向位置，并进行组件初始化布局
    [self createFrameLayout:[UIApplication sharedApplication].statusBarOrientation];
    //加载工具栏视图
    ToolBarViewController *toolBarViewController = [[ToolBarViewController alloc] initWithNibName:@"ToolBarViewController" bundle:nil];
    self.toolBarViewController = toolBarViewController;
    [toolBarViewController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//实现屏幕的旋转自适应
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self createFrameLayout: toInterfaceOrientation];

}

- (NSUInteger)supportedInterfaceOrientations{
    
    //[NSNotificationCenter defaultCenter] addob
    return [super supportedInterfaceOrientations];
}

- (void)createFrameLayout:(UIInterfaceOrientation)interfaceOrientation{
    //竖版
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        _nameLabel.frame = CGRectMake(20, 100, 70, 30);
        _nameTextField.frame = CGRectMake(133, 100 , 135, 30);
        _pwdLabel.frame = CGRectMake(20, 206, 70, 30);
        _passwordTextField.frame = CGRectMake(133, 206, 135, 30);
        _submitButton.frame = CGRectMake(20, 300, 70, 45);
        _resetButton.frame = CGRectMake(198, 300, 70, 45);
    //横版
    }else{
        _nameLabel.frame = CGRectMake(50, 65, 160, 30);
        _nameTextField.frame = CGRectMake(200, 65 , 160, 30);
        _pwdLabel.frame = CGRectMake(50, 130, 160, 30);
        _passwordTextField.frame = CGRectMake(200, 130, 160, 30);
        _submitButton.frame = CGRectMake(50, 200, 70, 45);
        _resetButton.frame = CGRectMake(290, 200, 70, 45);
    }
}

- (void)forwordView{
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window setRootViewController: self.toolBarViewController];
    //释放引用
    self.toolBarViewController = nil;
    
}

- (IBAction)submit:(id)sender{
    if([NSString isBlank : self.nameTextField.text ]==YES){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"用户名不能为空!" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    if([NSString isBlank : self.passwordTextField.text ]==YES){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"密码不能为空!" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    [self forwordView];
}

- (IBAction)reset:(id)sender{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"是否重置数据" delegate:self cancelButtonTitle:@"NO" destructiveButtonTitle:@"YES" otherButtonTitles: nil];
    [sheet showInView:self.view];
    [sheet release];

}

- (IBAction)textFieldDoneEdit:(id)sender{
    
    [sender resignFirstResponder];
}

- (IBAction)hideKeyboard:(id)sender{
    [self.view endEditing:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == [actionSheet destructiveButtonIndex]){
        self.nameTextField.text = nil;
        self.passwordTextField.text = nil;
    }
}

- (void) dealloc{

    [_toolBarViewController release];
    [_nameLabel release];
    [_nameTextField release];
    [_pwdLabel release];
    [_passwordTextField release];
    [_submitButton release];
    [_resetButton release];
    [super dealloc];
}

@end
