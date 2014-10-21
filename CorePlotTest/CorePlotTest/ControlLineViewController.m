//
//  ControlLineViewController.m
//  CorePlotTest
//
//  Created by sunlight on 14-9-1.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "ControlLineViewController.h"
NSString *const kDataLine    = @"数据线";
NSString *const kCenterLine  = @"中心线";
NSString *const kControlLine = @"控制线";
NSString *const kWarningLine = @"警告线";
static const NSUInteger numberOfPoints = 11;

@interface ControlLineViewController ()

@property (nonatomic,strong) NSArray *plotData;

@property (nonatomic,assign) double meanValue;
@property (nonatomic,assign) double standardError;

@end

@implementation ControlLineViewController


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
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self generateData];
    [self createLines];
}
//生成测试数据
-(void)generateData
{
    if ( self.plotData == nil ) {
        NSMutableArray *contentArray = [NSMutableArray array];
        
        double sum = 0.0;
        
        for ( NSUInteger i = 0; i < numberOfPoints; i++ ) {
            double y = 12.0 * rand() / (double)RAND_MAX + 5.0;
            sum += y;
            [contentArray addObject:@(y)];
        }
        
        self.plotData = contentArray;
        
        self.meanValue = sum / numberOfPoints;
        
        sum = 0.0;
        for ( NSNumber *value in contentArray ) {
            double error = [value doubleValue] - self.meanValue;
            sum += error * error;
        }
        double stdDev = sqrt( ( 1.0 / (numberOfPoints - 1) ) * sum );
        self.standardError = stdDev / sqrt(numberOfPoints);
    }
}

- (void)createLines{
    
    CPTGraphHostingView *graphView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0.0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height-64.0)];
    graphView.collapsesLayers = NO;
    [graphView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [graphView setAutoresizesSubviews:YES];
    
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:graphView.bounds];
    graphView.hostedGraph = graph;
    [self.view addSubview:graphView];
    
    graph.title = @"TEST";
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color                = [CPTColor grayColor];
    textStyle.fontName             = @"Helvetica-Bold";
    textStyle.fontSize             = round( graph.bounds.size.height / CPTFloat(20.0) );
    graph.titleTextStyle           = textStyle;
    graph.titleDisplacement        = CPTPointMake( 0.0, textStyle.fontSize * CPTFloat(1.5) );
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
    graph.plotAreaFrame.plotArea.delegate = self;
    
    // Grid line styles
    CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];
    majorGridLineStyle.lineWidth = 0.75;
    majorGridLineStyle.lineColor = [[CPTColor colorWithGenericGray:0.2] colorWithAlphaComponent:0.75];
    
    CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
    minorGridLineStyle.lineWidth = 0.25;
    minorGridLineStyle.lineColor = [[CPTColor whiteColor] colorWithAlphaComponent:0.1];
    
    CPTMutableLineStyle *redLineStyle = [CPTMutableLineStyle lineStyle];
    redLineStyle.lineWidth = 10.0;
    redLineStyle.lineColor = [[CPTColor redColor] colorWithAlphaComponent:0.5];
    
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
    y.title       = @"Y Axis";
    y.titleOffset = 30.0;
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0) length:CPTDecimalFromDouble(10)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0) length:CPTDecimalFromDouble(20)];
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    //X轴拉伸 避免边界圆点显示不全
    [xRange expandRangeByFactor:CPTDecimalFromDouble(1.018)];
    //[yRange expandRangeByFactor:CPTDecimalFromDouble(1.01)];
    plotSpace.xRange = xRange;
    plotSpace.yRange = yRange;
    y.plotSpace = plotSpace;
    
    
    // Center line
    CPTScatterPlot *centerLinePlot = [[CPTScatterPlot alloc] init];
    centerLinePlot.identifier = kCenterLine;
    
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineWidth          = 2.0;
    lineStyle.lineColor          = [CPTColor greenColor];
    centerLinePlot.dataLineStyle = lineStyle;
    
    centerLinePlot.dataSource = self;
    [graph addPlot:centerLinePlot];
    
    // Control lines
    CPTScatterPlot *controlLinePlot = [[CPTScatterPlot alloc] init];
    controlLinePlot.identifier = kControlLine;
    
    lineStyle                     = [CPTMutableLineStyle lineStyle];
    lineStyle.lineWidth           = 2.0;
    lineStyle.lineColor           = [CPTColor redColor];
    lineStyle.dashPattern         = @[@10, @6];
    controlLinePlot.dataLineStyle = lineStyle;
    
    controlLinePlot.dataSource = self;
    [graph addPlot:controlLinePlot];
    
    // Warning lines
    CPTScatterPlot *warningLinePlot = [[CPTScatterPlot alloc] init];
    warningLinePlot.identifier = kWarningLine;
    
    lineStyle                     = [CPTMutableLineStyle lineStyle];
    lineStyle.lineWidth           = 1.0;
    lineStyle.lineColor           = [CPTColor orangeColor];
    lineStyle.dashPattern         = @[@5, @5];
    warningLinePlot.dataLineStyle = lineStyle;
    
    warningLinePlot.dataSource = self;
    [graph addPlot:warningLinePlot];
    
    // Data line
    CPTScatterPlot *linePlot = [[CPTScatterPlot alloc] init];
    linePlot.identifier = kDataLine;
    lineStyle              = [CPTMutableLineStyle lineStyle];
    lineStyle.lineWidth    = 3.0;
    linePlot.dataLineStyle = lineStyle;
    
    linePlot.dataSource = self;
    [graph addPlot:linePlot];
    
    // Add plot symbols
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor blackColor];
    //设置点的符号
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill      = [CPTFill fillWithColor:[CPTColor lightGrayColor]];
    plotSymbol.lineStyle = symbolLineStyle;
    //符号,标记的大小
    plotSymbol.size      = CGSizeMake(10.0, 10.0);
    linePlot.plotSymbol  = plotSymbol;
    linePlot.delegate = self;
    linePlot.interpolation = CPTScatterPlotInterpolationCurved;
    linePlot.allowSimultaneousSymbolAndPlotSelection = YES;
    //增加热点的边缘
    linePlot.plotSymbolMarginForHitDetection = 5.0;
    
    
    //linePlot.delegate = self;
    // Auto scale the plot space to fit the plot data
    //CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    
    /*
    //自适应x,y轴坐标 改为固定
    [plotSpace scaleToFitPlots:@[linePlot]];
    
    // Adjust visible ranges so plot symbols along the edges are not clipped
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    
    x.orthogonalCoordinateDecimal = yRange.location;
    y.orthogonalCoordinateDecimal = xRange.location;
    
    x.visibleRange = xRange;
    y.visibleRange = yRange;
    
    x.gridLinesRange = yRange;
    y.gridLinesRange = xRange;
    
    [xRange expandRangeByFactor:CPTDecimalFromDouble(1.05)];
    [yRange expandRangeByFactor:CPTDecimalFromDouble(1.05)];
    plotSpace.xRange = xRange;
    plotSpace.yRange = yRange;
    */
    
    // Add legend 图例
    graph.legend                 = [CPTLegend legendWithPlots:@[linePlot, controlLinePlot, warningLinePlot, centerLinePlot]];
    graph.legend.textStyle       = x.titleTextStyle;
    graph.legend.borderLineStyle = x.axisLineStyle;
    graph.legend.cornerRadius    = 5.0;
    graph.legend.numberOfRows    = 1;
    //样品的大小
    graph.legend.swatchSize      = CGSizeMake(25.0, 25.0);
    graph.legendAnchor           = CPTRectAnchorBottom;
    graph.legendDisplacement     = CGPointMake(0.0, 12.0);
    
    //需要刷新数据
    [graph reloadDataIfNeeded];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Plot Data Source Methods

//plot 代理 轮询plot一共有多少记录
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    NSLog(@"%@",plot.identifier);
    if ( plot.identifier == kDataLine ) {
        return [self.plotData count];
    }
    else if ( plot.identifier == kCenterLine ) {
        return 2;
    }
    else {
        return 5;
    }
}

//轮询上面给的点得值 fieldEnum 包含X,Y
//                index包含 0到Count-1
-(double)doubleForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    double number = NAN;
    
    switch ( fieldEnum ) {
        case CPTScatterPlotFieldX:
            if ( plot.identifier == kDataLine ) {
                number = (double)index;
            }
            else {
                switch ( index % 3 ) {
                    case 0:
                        number = 0.0;
                        break;
                        
                    case 1:
                        number = (double)([self.plotData count] - 1);
                        break;
                        
                    case 2:
                        number = NAN;
                        break;
                }
            }
            
            break;
            
        case CPTScatterPlotFieldY:
            if ( plot.identifier == kDataLine ) {
                number = [self.plotData[index] doubleValue];
            }else if ( plot.identifier == kCenterLine ) {
                number = self.meanValue;
            }else if ( plot.identifier == kControlLine ) {
                switch ( index ) {
                    case 0:
                    case 1:
                        number = self.meanValue + 3.0 * self.standardError;
                        break;
                        
                    case 2:
                        number = NAN;
                        break;
                        
                    case 3:
                    case 4:
                        number = self.meanValue - 3.0 * self.standardError;
                        break;
                }
            }
            else if ( plot.identifier == kWarningLine ) {
                switch ( index ) {
                    case 0:
                    case 1:
                        number = self.meanValue + 2.0 * self.standardError;
                        break;
                        
                    case 2:
                        number = NAN;
                        break;
                        
                    case 3:
                    case 4:
                        number = self.meanValue - 2.0 * self.standardError;
                        break;
                }
            }
            
            break;
    }
    
    return number;
}
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)idx{
    
    CPTMutableTextStyle *textStyle = [[CPTMutableTextStyle alloc] init];
    textStyle.fontName = [[UIFont familyNames] firstObject];
    textStyle.fontSize = 12.0;
    textStyle.color = [CPTColor blueColor];
    CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%.1f",[self.plotData[idx] doubleValue]] style:textStyle];

    return textLayer;

}
#pragma -mark 散点图代理
-(void)scatterPlot:(CPTScatterPlot *)plot plotSymbolWasSelectedAtRecordIndex:(NSUInteger)idx{
    NSLog(@"%d",idx);
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
