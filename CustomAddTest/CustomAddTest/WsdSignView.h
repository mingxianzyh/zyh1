//
//  SignView.h
//  CustomAddTest
//
//  Created by sunlight on 14-5-16.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

//签名类型枚举
typedef enum WsdSignType{
    //正常连线状态
    WsdSignTypeNormal = 0,
    //二次贝赛尔连线状态(取中间点和上一点)
    WsdSignTypeBezier
}WsdSignType;


#import <UIKit/UIKit.h>

//签名视图View
@interface WsdSignView : UIView

//签名状态(只读)
@property (nonatomic,assign,readonly) BOOL isSigning;
//当前签名类型
@property (nonatomic,assign) WsdSignType wsdSignType;
//是否启用，长按清除手势 默认启用
@property (nonatomic,assign) BOOL isUseLongPressRemoveGesture;

//是否有签名内容
- (BOOL) hasContent;
//开始签名
- (void)beginSign;
//结束签名
- (void)endSign;
//清除签名
- (void)clearSign;
//获取当前签名图像(默认当前大小)
- (UIImage *)gainCurrentSignImage;
//获取指定尺寸大小当前签名图像
- (UIImage *)gainCurrentSignImageBySize:(CGSize) size;

@end
