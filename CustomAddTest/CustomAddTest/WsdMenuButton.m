//
//  WsdMenuButton.m
//  CustomAddTest
//
//  Created by sunlight on 14-5-13.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdMenuButton.h"
@interface WsdMenuButton()

@end

@implementation WsdMenuButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


+ (id)wsdMenuButtonWithType:(UIButtonType)buttonType HasRemoveButton:(BOOL)hasRemoveButton{

    WsdMenuButton *button = [WsdMenuButton buttonWithType:buttonType];
    if (button&&hasRemoveButton) {
        //增加删除按钮
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //在父Button的位置为左上角
        deleteButton.frame = CGRectMake(0.0f, 0.0f, kDeleteButtonWidth, kDeleteButtonHeight);
        [deleteButton setBackgroundImage:[UIImage imageNamed:@"deleteButton"] forState:UIControlStateNormal];
        [deleteButton addTarget:button action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
        [button addSubview:deleteButton];
        deleteButton.hidden = YES;
        button.deleteButton = deleteButton;
    }
    //增加长按手势控制器
    UILongPressGestureRecognizer *longGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:button action:@selector(longPress:)];
    //设置长按的时间
    longGestureRecognizer.minimumPressDuration = 1.0f;
    [button addGestureRecognizer:longGestureRecognizer];
    button.bounds = CGRectMake(0.0f, 0.0f, kMenuButtonWidth, kMenuButtonHeight);
    return button;
}

- (void)longPress:(UILongPressGestureRecognizer *)longGestureRecognizer{
    
    if ([self.delegate respondsToSelector:@selector(longPressMenuButton)]) {
        [self.delegate longPressMenuButton];
    }
    
}

//删除按钮点击事件
- (void)clickDeleteButton:(UIButton *)deleteButton{
    //移除事件交给代理实现
    if ([self.delegate respondsToSelector:@selector(clickLittleDeleteButton:)]) {
        [self.delegate clickLittleDeleteButton:self];
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
