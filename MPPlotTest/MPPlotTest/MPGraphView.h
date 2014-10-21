//
//  MPGraphView.h
//
//
//  Created by Alex Manzella on 18/05/14.
//  Copyright (c) 2014 mpow. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MPPlot.h"

@protocol MPGraphViewDelegate <NSObject>

@required
- (NSInteger)numbersOfLines;//总线数
//每一条线对应的值集
- (NSArray *)valuesForLineIndex:(NSInteger)index;

@optional
//每一条线对应的填充渐变颜色(不实现,或者返回为nil表示不填充)
- (NSArray *)gradientFillColorsForLineIndex:(NSInteger)index;
//每一条线对应的点的大小
- (CGSize)sizeOfDotAtLineIndex:(NSInteger)index;
//每一条线是否显示数据明细
- (BOOL)isShowDetailAtLineIndex:(NSInteger)index;
//每一条曲线是否圆滑
- (BOOL)isCurveAtLineIndex:(NSInteger)index;
//每条曲线圆滑的精度
- (float)curveGranularityForLineIndex:(NSInteger)index;
//每一条线对应的点的颜色
- (UIColor *)colorOfDotAtLineIndex:(NSInteger)index;
//每一条线本身的颜色
- (UIColor *)colorOfLineAtLineIndex:(NSInteger)index;
//每一条线的线宽
- (float)lineWidthForLineIndex:(NSInteger)index;

//X的标题 0是否指原点由isOriginAtX决定
- (NSString *)titleOfXcale:(NSInteger)xIndex;
//X轴字体属性定义 NSFontAttributeName..
- (NSDictionary *)titleAttributesForAxisX;
//Y轴字体属性定义 NSFontAttributeName..
- (NSDictionary *)titleAttributesForAxisY;
//圆点明细字体属性定义 NSFontAttributeName..
- (NSDictionary *)titleAttributesForDotDetailAtLineIndex:(NSInteger)index;
//获取Y轴刻度总个数
- (NSInteger)numbersOfYScales:(MPPlot *)plot;

@end


//线条,曲线
@interface MPGraphView : MPPlot{
    
    float spaceX;
    NSInteger xCount;
}

@property (nonatomic,weak) id<MPGraphViewDelegate> delegate;

@property (nonatomic,assign) BOOL curved; //default NO

@property (nonatomic,assign) float curveGranularity; //曲线的粒度 default 1.0

@property (nonatomic,assign) float axisLineWidth;//坐标轴的宽带 default 1.0

@property (nonatomic,assign) BOOL isFirstBlank;//是否第一个位置空白 defaule YES

@property (nonatomic,assign) BOOL isLastBlank;//是否最后一个位置空白 default YES

@property (nonatomic,assign) BOOL isShowHorizonLine;//是否显示水平的刻度线(当画坐标时候有效)
@property (nonatomic,assign) BOOL isDrawAxis;//是否画坐标轴,默认为YES

@property (nonatomic,strong) UIColor * axisColor;//axis color(default black)

@property (nonatomic,assign) BOOL isDrawYParallelLines;//是否画Y轴平行线 default NO

@property (nonatomic,assign) BOOL isOriginAtX;//是否原点属于X轴显示 default NO

@end
