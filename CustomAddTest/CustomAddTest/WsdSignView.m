//
//  SignView.m
//  CustomAddTest
//
//  Created by sunlight on 14-5-16.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

//计算中间点函数
static CGPoint gainMiddlePoint(CGPoint point1,CGPoint point2){
    
    CGPoint point = CGPointMake((point1.x + point2.x)/2.0, (point1.y + point2.y)/2.0);
    return point;
}

#import "WsdSignView.h"
#import "UIImage+Ext.h"

@interface WsdSignView ()

//贝塞尔路径对象
@property (nonatomic,strong) UIBezierPath *path;

//上次触点
@property (nonatomic,assign) CGPoint prePoint;

@end

@implementation WsdSignView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.path = [UIBezierPath bezierPath];
        //设置线宽
        self.path.lineWidth = 3.0;
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        panGesture.maximumNumberOfTouches = 1;
        panGesture.minimumNumberOfTouches = 1;
        [self addGestureRecognizer:panGesture];
        self.isUseLongPressRemoveGesture = YES;
    }
    return self;
}

#pragma normal method begin
//设置是否启用长按手势识别器
- (void)setIsUseLongPressRemoveGesture:(BOOL)isUseLongPressRemoveGesture{
    _isUseLongPressRemoveGesture = isUseLongPressRemoveGesture;
    if (isUseLongPressRemoveGesture) {
        //增加长按识别器
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPressGesture.minimumPressDuration = 1.0f;
        [self addGestureRecognizer:longPressGesture];
    }
}

//开始签名
- (void)beginSign{
    [self clearSign];
    _isSigning = YES;
    [self setNeedsDisplay];
}
//结束签名
- (void)endSign{
    _isSigning = NO;
}
//清除签名
- (void)clearSign{
    [self.path removeAllPoints];
    [self setNeedsDisplay];
}
//是否有内容
- (BOOL)hasContent{
    return ![self.path isEmpty];
}
//获取当前签名图像(默认当前大小)
- (UIImage *)gainCurrentSignImage{
    
    UIGraphicsBeginImageContext(self.bounds.size);
    //将当前图像映射到画图上下文
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    //获取当前上下文对应的图像
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图,移除绘图环境
    UIGraphicsEndImageContext();
    return image;
}
//获取指定尺寸大小当前签名图像
- (UIImage *)gainCurrentSignImageBySize:(CGSize) size{
    UIGraphicsBeginImageContext(self.bounds.size);
    //将当前图像映射到画图上下文
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    //获取当前上下文对应的图像
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图,移除绘图环境
    UIGraphicsEndImageContext();
    return [image imageByScalingAndCroppingForSize:size];
}
#pragma end

#pragma private method begin

- (void)longPress:(UILongPressGestureRecognizer *)longPressGesture{
    if (_isSigning&&self.hasContent) {
        [self.path removeAllPoints];
        [self setNeedsDisplay];
    }
}

- (void)pan:(UIPanGestureRecognizer *)panGesture{
    if (_isSigning) {
        CGPoint point = [panGesture locationInView:self];
        if (panGesture.state == UIGestureRecognizerStateBegan) {
            [self.path moveToPoint:point];
        }else if(panGesture.state == UIGestureRecognizerStateChanged){
            switch (self.wsdSignType) {
                case WsdSignTypeNormal:{
                    
                    [self.path addLineToPoint:point];
                     break;
                }
                case WsdSignTypeBezier:{
                    CGPoint middllePoint = gainMiddlePoint(self.prePoint, point);
                    //画二次贝塞尔曲线 使用现在点和上一次点的中间点与上一次的点进行绘画(会比上面两种更加圆滑)
                    [self.path addQuadCurveToPoint:middllePoint controlPoint:self.prePoint];
                    break;
                }
                default:
                    break;
            }

        }
        self.prePoint = point;
        [self setNeedsDisplay];
    }
}
#pragma end


#pragma override begin
- (void)drawRect:(CGRect)rect
{
    //设置当前上下文画笔颜色
    if (![self.path isEmpty]) {
        [[UIColor blackColor] setStroke];
        [self.path stroke];
    }
}
- (void)dealloc{
    self.path = nil;
}
#pragma end

@end
