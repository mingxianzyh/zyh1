//
//  WsdSegmentView.m
//  ViewTest
//
//  Created by sunlight on 14-5-12.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//
#define kSegmentButtonHeight 35
#define kSegmentButtonWidth 90

#import "WsdSegmentView.h"

//自定义button
@interface MyButton : UIButton{
    
}
@end
@implementation MyButton
//(取消高亮的设置，(该方法会在touch enters/exits 自动调用))
- (void)setHighlighted:(BOOL)highlighted{
}
@end


//特殊类别
@interface WsdSegmentView(){
    
    UIButton *_currentButton;
}
@end

@implementation WsdSegmentView

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

- (id)initWithTitles:(NSArray *)titles{
    if (self = [super init]) {
        self.titles = titles;
    }
    return self;
}

//设置标题，并替换当前view
- (void)setTitles:(NSArray *)titles{
    //数组内容一样则返回
    if ([_titles isEqualToArray:titles]) {
        return;
    }
    _titles = titles;
    
    //1.移除所有的button
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    int count = [self.titles count];
    //2.增加button
    for (int i = 0 ; i < count; i++) {
        MyButton *button  = [MyButton buttonWithType:UIButtonTypeCustom];
        //按钮点击事件后，通过tag来通知代理点击了第几个按钮
        button.tag = i;
        if (i == 0) {
            [button setBackgroundImage:[self resizableImageByImageName:@"Segmented_Left_Normal"] forState:UIControlStateNormal];
            [button setBackgroundImage:[self resizableImageByImageName:@"Segmented_Left_Selected"]forState:UIControlStateSelected];
            [self clickSegmentButton:button];
        }else if(i == count-1){
            [button setBackgroundImage:[self resizableImageByImageName:@"Segmented_Right_Normal"] forState:UIControlStateNormal];
            [button setBackgroundImage:[self resizableImageByImageName:@"Segmented_Right_Selected"]forState:UIControlStateSelected];
        }else{
            [button setBackgroundImage:[self resizableImageByImageName:@"Segmented_Center_Normal"] forState:UIControlStateNormal];
            [button setBackgroundImage:[self resizableImageByImageName:@"Segmented_Center_Selected"]forState:UIControlStateSelected];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [button setHighlighted:NO];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setHighlighted:NO];
        //3.增加点击事件
        [button addTarget:self action:@selector(clickSegmentButton:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(i *kSegmentButtonWidth, 0, kSegmentButtonWidth, kSegmentButtonHeight);
        [self addSubview:button];
    }
    self.bounds = CGRectMake(0.0f, 0.0f, count*kSegmentButtonWidth, kSegmentButtonHeight);
}

//拉伸图片
- (UIImage *)resizableImageByImageName:(NSString *)imageName{

    UIImage *image = [UIImage imageNamed:imageName];
    UIEdgeInsets insets = UIEdgeInsetsMake(image.size.height*0.5f, image.size.width*0.5f, image.size.height*0.5f, image.size.width*0.5f);
    //UIImageResizingModeStretch  拉伸
    //UIImageResizingModeTile  平铺
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
//    CGFloat leftCap = image.size.width * 0.5f;
//    CGFloat topCap = image.size.height * 0.5f;
//    image =  [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
    return image;
}

- (void)clickSegmentButton:(UIButton *)button{

    _currentButton.selected = NO;
    button.selected = YES;
    _currentButton = button;
    if ([self.delegate respondsToSelector:@selector(wsdSegmentView:DidSelectSegmentAtIndex:)]) {
        [self.delegate wsdSegmentView:self DidSelectSegmentAtIndex:button.tag];
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
