//
//  WsdLoginAlertView.m
//  SupplierQuestionnaire
//
//  Created by sunlight on 14-6-13.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdLoginAlertView.h"

@interface WsdLoginAlertView ()

@property (nonatomic,strong) UIView *backgroundView;

@property (nonatomic,strong) UIView *contentView;

@end

@implementation WsdLoginAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<WsdAlertViewDelegate>*/)delegate buttonTitles:(NSString *)buttonTitles, ...{

    self = [super init];
    if (self) {
        NSMutableArray *buttonArray = [[NSMutableArray alloc] init];
        if (buttonTitles) {
            //处理可变参数
            NSString *eachString;
            //声明list
            va_list list;
            //开始，初始化list
            va_start(list, buttonTitles);
            //不包含第一个
            [buttonArray addObject:buttonTitles];
            //循环list
            while ((eachString = va_arg(list, NSString*))) {
                [buttonArray addObject:eachString];
            }
            //结束
            va_end(list);
        }
        //加透明的100 是为了显示tableView，当tableView的frame超过 父类的frame的时候，点击和滑动事件失效
        //后面使用可以去掉这个tableView 额外height，也可以不处理
        self.bounds = CGRectMake(0.0, 0.0, 300.0, 195.0+100);
        
        UIView *contentView = [[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 300.0, 195.0)];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 20.0, 300.0, 20.0)];
        titleLabel.font = [UIFont systemFontOfSize:19.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        [contentView addSubview:titleLabel];
        
        //用户名
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 60.0, 60.0, 30.0)];
        nameLabel.text = @"用户名:";
        [contentView addSubview:nameLabel];
        
        UITextField *userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(82.0, 60.0, 200.0, 30.0)];
        userNameTextField.placeholder = @"用户名不能为空";
        userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.userNameTextField = userNameTextField;
        [contentView addSubview:userNameTextField];
        
        //密码
        UILabel *pwdlabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 100.0, 60.0, 30.0)];
        pwdlabel.text = @"密    码:";
        [contentView addSubview:pwdlabel];
        
        UITextField *pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(82.0, 100.0, 200.0, 30.0)];
        pwdTextField.secureTextEntry = YES;
        pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
        pwdTextField.placeholder = @"密码不能为空";
        pwdTextField.clearsOnBeginEditing = YES;
        self.passwordTextField = pwdTextField;
        [contentView addSubview:pwdTextField];
        
        //分割View
        UIColor *splitColor = [UIColor colorWithRed:177.0/255.0 green:177.0/255.0 blue:177.0/255.0 alpha:0.9];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 150.0, 300.0, 1.0)];
        view.backgroundColor = splitColor;
        [contentView addSubview:view];
        //按钮
        //按钮宽度(两个按钮只有一条分割线)
        float buttonWidth = (contentView.bounds.size.width / [buttonArray count] - ([buttonArray count] - 1));
        //float buttonHeight = self.bounds.size.height - view.frame.origin.y - view.frame.size.height;
        float buttonHeight = contentView.bounds.size.height - view.frame.origin.y - view.frame.size.height;
        float x = 0.0;
        for (int i = 0 ; i < [buttonArray count]; i++) {
            //设置分割线
            if (i !=0) {
                UIView *splitButtonView = [[UIView alloc] initWithFrame:CGRectMake(x, 151, 1, buttonHeight)];
                splitButtonView.backgroundColor = splitColor;
                [contentView addSubview:splitButtonView];
                x = x+1;
            }
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            [button setTitle:buttonArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:53.0/255.0 green:114.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            button.frame = CGRectMake(x, 151, buttonWidth, buttonHeight);
            x += buttonWidth;
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];

            [contentView addSubview:button];
        }
        //初始化背景View
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //与alertView的背景一致
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBackground)];
        tapGR.numberOfTouchesRequired = 1;
        tapGR.numberOfTapsRequired = 1;
        [_backgroundView addGestureRecognizer:tapGR];
        
        //设置背景颜色
        contentView.backgroundColor = [UIColor colorWithRed:226/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
        //设置圆角
        contentView.layer.cornerRadius = 10;
        self.contentView = contentView;
        [self addSubview:contentView];
        self.delegate = delegate;
        
    }
    return self;
}
//显示弹出框
- (void)showAlertView{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.center = CGPointMake(window.bounds.size.width/2.0f,
                              window.bounds.size.height/2.0f +100.0/2);
    [window addSubview:self.backgroundView];
    [window addSubview:self];
    self.alpha = 0;
    
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1.0;
    } completion:^(BOOL finished) {

    }];
    
}
//隐藏弹出框
- (void)disShowAlertView{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
        self.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)clickButton:(UIButton *)button{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(clickButtonAtIndex:wsdAlertView:)]) {
            [self.delegate clickButtonAtIndex:button.tag wsdAlertView:self];
        }
    }
}
- (void)touchBackground{

    if ([self.delegate respondsToSelector:@selector(touchBackgroundView:)]) {
        [self.delegate touchBackgroundView:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
