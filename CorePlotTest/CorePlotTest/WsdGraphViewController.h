//
//  WsdGraphViewController.h
//  CorePlotTest
//
//  Created by sunlight on 14-9-5.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@class WsdGraphViewController;
@protocol WsdGraphViewControllerDelegate <NSObject>

//设置graph的标题
- (NSString *)genGraphTitleAfterViewDidLoad:(UIViewController*)vc;
- (CPTTextStyle *)textStyleForDetailLabelIdentify:(NSString *)identify vc:(UIViewController*)vc;
//设置图例相关属性
- (void)adjustGraphCPTLegend:(CPTLegend *)legend graph:(CPTGraph *)graph vc:(UIViewController*)vc;
//adjustGraphCPTLegend   Demo
/*
 CPTMutableTextStyle *textStyle = [[CPTMutableTextStyle alloc] init];
 textStyle.color = [CPTColor blueColor];
 CPTMutableLineStyle *lineStyle = [[CPTMutableLineStyle alloc] init];
 lineStyle.lineColor = [CPTColor blackColor];
 
 legend.numberOfRows    = 1;
 legend.textStyle       = textStyle;
 //legend.entryPaddingLeft = 20.0;
 //legend.titleOffset = 30.0;
 legend.fill            = [CPTFill fillWithColor:[CPTColor whiteColor]];
 legend.borderLineStyle = lineStyle;
 legend.cornerRadius    = 5.0;
 legend.swatchSize      = CGSizeMake(25.0, 25.0);
 graph.legendAnchor           = CPTRectAnchorBottom;
 graph.legendDisplacement     = CGPointMake(0.0, 12.0);
 */
//设置标题属性,区域,xy轴设置等其他设置,设置graph
- (void)adjustGraphAfterViewDidLoad:(CPTGraph *)graph vc:(UIViewController*)vc;
//折线adjustGraphAfterViewDidLoad  Demo
/*
 CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
 textStyle.color                = [CPTColor grayColor];
 textStyle.fontName             = @"Helvetica-Bold";
 textStyle.fontSize             = 22.0;
 graph.titleTextStyle           = textStyle;
 graph.titleDisplacement        = CPTPointMake( 0.0, textStyle.fontSize * CPTFloat(1.15) );
 graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
 
 CGFloat boundsPadding = round( graph.bounds.size.width / CPTFloat(20.0) ); // Ensure that padding falls on an integral pixel
 graph.paddingLeft = boundsPadding;
 if ( graph.titleDisplacement.y > 0.0 ) {
 graph.paddingTop = graph.titleTextStyle.fontSize * 2.0;
 }
 else {
 graph.paddingTop = boundsPadding;
 }
 graph.paddingRight  = boundsPadding;
 graph.paddingBottom = boundsPadding;
 
 graph.plotAreaFrame.paddingTop    = 15.0;
 graph.plotAreaFrame.paddingRight  = 15.0;
 graph.plotAreaFrame.paddingBottom = 60.0;
 graph.plotAreaFrame.paddingLeft   = 35.0;
 graph.plotAreaFrame.masksToBorder = NO;
 
 // Grid line styles
 CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];
 majorGridLineStyle.lineWidth = 0.75;
 majorGridLineStyle.lineColor = [[CPTColor colorWithGenericGray:0.2] colorWithAlphaComponent:0.75];
 
 CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
 minorGridLineStyle.lineWidth = 0.25;
 minorGridLineStyle.lineColor = [[CPTColor whiteColor] colorWithAlphaComponent:0.1];
 
 NSNumberFormatter *labelFormatter = [[NSNumberFormatter alloc] init];
 //设置没有小数点
 labelFormatter.maximumFractionDigits = 0;
 
 // Axes
 // X axis
 CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
 CPTXYAxis *x          = axisSet.xAxis;
 //两个主刻度之间多少个小刻度
 x.minorTicksPerInterval       = 0;
 
 NSArray *array = @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
 //自定义主刻度下标
 x.majorTickLocations = [NSSet setWithArray:array];
 NSMutableSet *sets = [[NSMutableSet alloc] init];
 //统一风格
 CPTMutableTextStyle *style1 = [[CPTMutableTextStyle alloc] init];
 style1.color = [CPTColor redColor];
 style1.fontSize = 16.0;
 style1.fontName             = @"Helvetica";
 for (int i = 0 ; i < [array count] ; i++) {
 CPTAxisLabel *label1 = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%d月",i+1] textStyle:style1];
 label1.tickLocation = CPTDecimalFromDouble([array[i] doubleValue]);
 [sets addObject:label1];
 }
 [x setAxisLabels:sets];
 x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
 x.majorIntervalLength = CPTDecimalFromDouble(1);
 //自定义主刻度label
 x.labelingPolicy = CPTAxisLabelingPolicyNone;
 //在给定的locations 标记为主刻度
 //x.labelingPolicy     = CPTAxisLabelingPolicyLocationsProvided;
 x.majorGridLineStyle = majorGridLineStyle;
 x.minorGridLineStyle = minorGridLineStyle;
 x.labelFormatter     = labelFormatter;
 //x.title       = @"X Axis";
 x.titleOffset = 30.0;
 
 // Y axis
 CPTXYAxis *y = axisSet.yAxis;
 y.labelingPolicy     = CPTAxisLabelingPolicyAutomatic;
 y.minorTicksPerInterval = 4;
 y.majorGridLineStyle = majorGridLineStyle;
 y.minorGridLineStyle = minorGridLineStyle;
 y.labelFormatter     = labelFormatter;
 y.title       = @"数据";
 y.titleOffset = 30.0;
 
 CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
 plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0) length:CPTDecimalFromDouble(10)];
 plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0) length:CPTDecimalFromDouble(20)];
 CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
 CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
 //X轴拉伸 避免边界圆点显示不全
 //[xRange expandRangeByFactor:CPTDecimalFromDouble(1.018)];
 //[yRange expandRangeByFactor:CPTDecimalFromDouble(1.01)];
 plotSpace.xRange = xRange;
 plotSpace.yRange = yRange;
 y.plotSpace = plotSpace;
 */

@end

@interface WsdGraphViewController : UIViewController
//是否显示明细数据label(默认yes)
@property (nonatomic,assign) BOOL isShowDetailLabel;
//当前GraphView
@property (nonatomic,strong,readonly) CPTGraphHostingView *graphView;
//当前graph
@property (nonatomic,strong) CPTGraph *graph;
//代理
@property (nonatomic,weak) id<WsdGraphViewControllerDelegate> delegatge;

@end
