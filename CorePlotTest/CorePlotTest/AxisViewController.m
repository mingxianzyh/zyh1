//
//  AxisViewController.m
//  CorePlotTest
//
//  Created by sunlight on 14-9-1.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "AxisViewController.h"
#import "CorePlot-CocoaTouch.h"
#import "CPTTextStylePlatformSpecific.h"

@interface AxisViewController ()

@end

@implementation AxisViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createAxisView];
}

//画坐标轴
- (void)createAxisView{
    
    CPTGraphHostingView *graphView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0.0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height-64.0)];
    [self.view addSubview:graphView];
    graphView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    //图表图层
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:graphView.bounds];
    //标题设置
    graph.title = @"test";
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color                = [CPTColor blackColor];
    textStyle.fontName             = @"Helvetica-Bold";
    textStyle.fontSize             = round( graphView.bounds.size.height / CPTFloat(20.0) );
    //标题风格
    graph.titleTextStyle           = textStyle;
    //标题位移量
    graph.titleDisplacement        = CPTPointMake( 0.0, textStyle.fontSize * CPTFloat(1.5) );
    //graph.titleDisplacement        = CPTPointMake( 0.0, 1.0 );
    //标题位置
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    //边距设置
    CGFloat boundsPadding = round( graphView.bounds.size.width / CPTFloat(20.0) ); // Ensure that padding falls on an integral pixel
    
    graph.paddingLeft = boundsPadding;
    
    if ( graph.titleDisplacement.y > 0.0 ) {
        graph.paddingTop = graph.titleTextStyle.fontSize * 2.0;
    }
    else {
        graph.paddingTop = boundsPadding;
    }
    
    graph.paddingRight  = boundsPadding;
    graph.paddingBottom = boundsPadding;
    
    //图表图层填充颜色
    graph.fill = [CPTFill fillWithColor:[CPTColor whiteColor]];
    
    //图形区设置
    // Plot area
    //graph.plotAreaFrame.fill          = [CPTFill fillWithColor:[CPTColor greenColor]];
    graph.plotAreaFrame.paddingTop    = 20.0;
    graph.plotAreaFrame.paddingBottom = 50.0;
    graph.plotAreaFrame.paddingLeft   = 50.0;
    graph.plotAreaFrame.paddingRight  = 50.0;
    //graph.plotAreaFrame.cornerRadius  = 10.0;
    //graph.plotAreaFrame.masksToBorder = NO;
    //坐标轴区域边框的线条风格
    //graph.plotAreaFrame.axisSet.borderLineStyle = [CPTLineStyle lineStyle];
    graph.plotAreaFrame.plotArea.fill = [CPTFill fillWithColor:[CPTColor whiteColor]];
    
    
    //设置 plot 间隔
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0) length:CPTDecimalFromDouble(100.0)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0) length:CPTDecimalFromDouble(500.0)];
    
    // Line styles
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 3.0;
    axisLineStyle.lineCap   = kCGLineCapRound;
    
    CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];
    majorGridLineStyle.lineWidth = 0.75;
    majorGridLineStyle.lineColor = [CPTColor redColor];
    
    CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
    minorGridLineStyle.lineWidth = 0.25;
    minorGridLineStyle.lineColor = [CPTColor blueColor];
    
    // Text styles
    CPTMutableTextStyle *axisTitleTextStyle = [CPTMutableTextStyle textStyle];
    axisTitleTextStyle.fontName = @"Helvetica-Bold";
    axisTitleTextStyle.fontSize = 14.0;
    
    // Axes
    // Label x axis with a fixed interval policy
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x          = axisSet.xAxis;
    
    //是否画分割labyers  Use separate layers for drawing grid lines
    x.separateLayers              = NO;
    //与垂直坐标轴相交点的值
    x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
    //主要的刻度间隔
    x.majorIntervalLength         = CPTDecimalFromDouble(20.0);
    //两个主刻度之间多少个小刻度
    x.minorTicksPerInterval       = 4;
    //标记的方向
    x.tickDirection               = CPTSignNone;
    //坐标线的风格
    x.axisLineStyle               = axisLineStyle;
    //主要刻度线长度
    x.majorTickLength             = 6.0;
    //主要标记线风格
    x.majorTickLineStyle          = axisLineStyle;
    //主要grid线风格
    //x.majorGridLineStyle          = majorGridLineStyle;
    //小刻度线长度
    x.minorTickLength             = 8.0;
    //x.minorGridLineStyle          = minorGridLineStyle;
    x.title                       = @"X Axis";
    x.titleTextStyle              = axisTitleTextStyle;
    x.titleOffset                 = 25.0;
    //在连续主刻度之间的线条颜色
    //x.alternatingBandFills        = @[[[CPTColor redColor] colorWithAlphaComponent:0.1], [[CPTColor greenColor] colorWithAlphaComponent:0.1]];
    x.delegate                    = self;
    
    // Label y with an automatic labeling policy.
    axisLineStyle.lineColor = [CPTColor greenColor];
    
    CPTXYAxis *y = axisSet.yAxis;
    y.plotSpace = plotSpace;
    y.majorIntervalLength = CPTDecimalFromDouble(100);
    y.separateLayers        = NO;
    y.minorTicksPerInterval = 9;
    //刻度相对于坐标轴的位置(左右居中)
    y.tickDirection         = CPTSignNegative;
    y.axisLineStyle         = axisLineStyle;
    //主要刻度线条长度
    y.majorTickLength       = 12.0;
    y.majorTickLineStyle    = axisLineStyle;
    y.majorGridLineStyle    = majorGridLineStyle;
    y.minorTickLength       = 4.0;
    y.minorGridLineStyle    = minorGridLineStyle;
    y.title                 = @"Y Axis";
    y.titleTextStyle        = axisTitleTextStyle;
    y.titleOffset           = 30.0;
    //y.alternatingBandFills  = @[[[CPTColor blueColor] colorWithAlphaComponent:0.1], [NSNull null]];
    y.delegate              = self;
    
    CPTFill *bandFill = [CPTFill fillWithColor:[[CPTColor darkGrayColor] colorWithAlphaComponent:0.5]];
    //增加背景限制带
    //[y addBackgroundLimitBand:[CPTLimitBand limitBandWithRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(7.0) length:CPTDecimalFromDouble(1.5)] fill:bandFill]];
    //[y addBackgroundLimitBand:[CPTLimitBand limitBandWithRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(1.5) length:CPTDecimalFromDouble(3.0)] fill:bandFill]];
    
    // Label y2 with an equal division labeling policy.
    axisLineStyle.lineColor = [CPTColor orangeColor];
    
    CPTXYAxis *y2 = [[CPTXYAxis alloc] init];
    y2.coordinate                  = CPTCoordinateY;
    y2.plotSpace                   = plotSpace;
    y2.majorIntervalLength = CPTDecimalFromDouble(200.0);
    y2.orthogonalCoordinateDecimal = CPTDecimalFromDouble(100.0);
    y2.labelingPolicy              = CPTAxisLabelingPolicyFixedInterval;
    y2.separateLayers              = NO;
    //主刻度的数量
    y2.preferredNumberOfMajorTicks = 6;
    //两个主刻度之间小刻度的数量
    y2.minorTicksPerInterval       = 9;
    y2.tickDirection               = CPTSignNone;
    y2.tickLabelDirection          = CPTSignPositive;
    y2.labelTextStyle              = y.labelTextStyle;
    y2.axisLineStyle               = axisLineStyle;
    y2.majorTickLength             = 12.0;
    y2.majorTickLineStyle          = axisLineStyle;
    y2.minorTickLength             = 8.0;
    y2.title                       = @"Y2 Axis";
    y2.titleTextStyle              = axisTitleTextStyle;
    y2.titleOffset                 = -50.0;
    y2.delegate                    = self;
    
    // Add the y2 axis to the axis set
    graph.axisSet.axes = @[x, y, y2];
    
    graphView.hostedGraph = graph;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
