//
//  CurveScatterViewController.m
//  CorePlotTest
//
//  Created by sunlight on 14-9-2.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "CurveScatterViewController.h"

@interface CurveScatterViewController ()

@property (nonatomic,strong) NSArray *plotData;
@property (nonatomic,strong) NSArray *plotData1;
@property (nonatomic,strong) NSArray *plotData2;
@property (nonatomic,strong) CPTPlotSpaceAnnotation *symbolTextAnnotation;
@property (nonatomic,strong) CPTGraph *graph;

@end

@implementation CurveScatterViewController

NSString *const kData   = @"数据线";
NSString *const kFirst  = @"第一条线";
NSString *const kSecond = @"第二条线";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)generateData
{
    if ( self.plotData == nil ) {
        NSMutableArray *contentArray = [NSMutableArray array];
        
        for ( NSUInteger i = 0; i < 11; i++ ) {
            NSNumber *x = @(1.0 + i * 0.05);
            NSNumber *y = @(1.2 * rand() / (double)RAND_MAX + 0.5);
            [contentArray addObject:@{ @"x": x, @"y": y }
             ];
        }
        
        self.plotData = contentArray;
    }
    
    if ( self.plotData1 == nil ) {
        NSMutableArray *contentArray = [NSMutableArray array];
        
        for ( NSUInteger i = 1; i < self.plotData.count; i++ ) {
            NSDictionary *point1 = self.plotData[i - 1];
            NSDictionary *point2 = self.plotData[i];
            
            double x1   = [(NSNumber *)point1[@"x"] doubleValue];
            double x2   = [(NSNumber *)point2[@"x"] doubleValue];
            double dx   = x2 - x1;
            double xLoc = (x1 + x2) * 0.5;
            
            double y1 = [(NSNumber *)point1[@"y"] doubleValue];
            double y2 = [(NSNumber *)point2[@"y"] doubleValue];
            double dy = y2 - y1;
            
            [contentArray addObject:@{ @"x": @(xLoc),
                                       @"y": @( (dy / dx) / 20.0 ) }
             ];
        }
        
        self.plotData1 = contentArray;
    }
    
    if ( self.plotData2 == nil ) {
        NSMutableArray *contentArray = [NSMutableArray array];
        
        for ( NSUInteger i = 1; i < self.plotData1.count; i++ ) {
            NSDictionary *point1 = self.plotData1[i - 1];
            NSDictionary *point2 = self.plotData1[i];
            
            double x1   = [(NSNumber *)point1[@"x"] doubleValue];
            double x2   = [(NSNumber *)point2[@"x"] doubleValue];
            double dx   = x2 - x1;
            double xLoc = (x1 + x2) * 0.5;
            
            double y1 = [(NSNumber *)point1[@"y"] doubleValue];
            double y2 = [(NSNumber *)point2[@"y"] doubleValue];
            double dy = y2 - y1;
            
            [contentArray addObject:@{ @"x": @(xLoc),
                                       @"y": @( (dy / dx) / 20.0 ) }
             ];
        }
        
        self.plotData2 = contentArray;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self generateData];
    
    
    // Do any additional setup after loading the view.
    CPTGraphHostingView *graphView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0.0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height-64.0)];
    //是否允许捏合缩小
    graphView.allowPinchScaling = NO;
    [graphView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:graphView];
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:graphView.bounds];
    graphView.hostedGraph = graph;
    self.graph = graph;
    
    //标题设置
    graph.title = @"圆滑散点图";
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color                = [CPTColor grayColor];
    textStyle.fontName             = @"Helvetica-Bold";
    textStyle.fontSize             = round( graphView.bounds.size.height / CPTFloat(20.0) );
    graph.titleTextStyle           = textStyle;
    graph.titleDisplacement        = CPTPointMake( 0.0, textStyle.fontSize * CPTFloat(1.5) );
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    
    //边界填充设置
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
    
    graph.plotAreaFrame.paddingLeft   += 55.0;
    graph.plotAreaFrame.paddingTop    += 40.0;
    graph.plotAreaFrame.paddingRight  += 55.0;
    graph.plotAreaFrame.paddingBottom += 40.0;
    graph.plotAreaFrame.masksToBorder  = NO;
    
    // Plot area delegate
    graph.plotAreaFrame.plotArea.delegate = self;
    
    
    // Setup scatter plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    //是否允许用户移动坐标或者放大/缩小坐标轴间隔
    //plotSpace.allowsUserInteraction = YES;
    //plotSpace.delegate              = self;
    
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
    
    //定义坐标的箭头风格
    CPTLineCap *lineCap = [CPTLineCap sweptArrowPlotLineCap];
    lineCap.size = CGSizeMake(15.0, 15.0);
    
    // Axes
    // Label x axis with a fixed interval policy
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x          = axisSet.xAxis;
    x.majorIntervalLength   = CPTDecimalFromDouble(0.1);
    x.minorTicksPerInterval = 4;
    x.majorGridLineStyle    = majorGridLineStyle;
    x.minorGridLineStyle    = minorGridLineStyle;
    //定义相对于图形区约束(与定义坐标方式取一种)
    x.axisConstraints       = [CPTConstraints constraintWithRelativeOffset:0.5];
    //x.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    
    lineCap.lineStyle = x.axisLineStyle;
    lineCap.fill      = [CPTFill fillWithColor:lineCap.lineStyle.lineColor];
    //设置坐标最大的一侧箭头
    x.axisLineCapMax  = lineCap;
    //设置坐标最小的一侧的箭头
    //x.axisLineCapMin  = lineCap;
    
    x.title       = @"X Axis";
    x.titleOffset = 30.0;
    
    // Label y with an automatic label policy.
    CPTXYAxis *y = axisSet.yAxis;
    y.labelingPolicy              = CPTAxisLabelingPolicyAutomatic;
    y.minorTicksPerInterval       = 4;
    y.preferredNumberOfMajorTicks = 8;
    y.majorGridLineStyle          = majorGridLineStyle;
    y.minorGridLineStyle          = minorGridLineStyle;
    y.axisConstraints             = [CPTConstraints constraintWithLowerOffset:0];
    y.labelOffset                 = 10.0;
    
    lineCap.lineStyle = y.axisLineStyle;
    lineCap.fill      = [CPTFill fillWithColor:lineCap.lineStyle.lineColor];
    y.axisLineCapMax  = lineCap;
    y.axisLineCapMin  = lineCap;
    
    y.title       = @"Y Axis";
    y.titleOffset = 32.0;
    
    // Set axes
    graph.axisSet.axes = @[x, y];
    
    // Create a plot that uses the data source method
    CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    dataSourceLinePlot.identifier = kData;
    
    // Make the data source line use curved interpolation
    dataSourceLinePlot.interpolation = CPTScatterPlotInterpolationCurved;
    
    CPTMutableLineStyle *lineStyle = [dataSourceLinePlot.dataLineStyle mutableCopy];
    lineStyle.lineWidth              = 3.0;
    lineStyle.lineColor              = [CPTColor greenColor];
    lineStyle.dashPattern = @[@5,@5];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    
    dataSourceLinePlot.dataSource = self;
    [graph addPlot:dataSourceLinePlot];
    
    /*
    //渐变处理
    CPTGradient *gradient = [CPTGradient gradientWithBeginningColor:[[CPTColor greenColor] colorWithAlphaComponent:0.5] endingColor:[CPTColor greenColor]];
    dataSourceLinePlot.areaFill = [CPTFill fillWithGradient:gradient];
    //不仅要设置渐变颜色,还要设置区域基本值
    dataSourceLinePlot.areaBaseValue = CPTDecimalFromDouble(0.0);
    */
    
    // First derivative
    CPTScatterPlot *firstPlot = [[CPTScatterPlot alloc] init];
    firstPlot.identifier    = kFirst;
    lineStyle.lineWidth     = 2.0;
    lineStyle.lineColor     = [CPTColor redColor];
    firstPlot.dataLineStyle = lineStyle;
    firstPlot.dataSource    = self;
    
    //[graph addPlot:firstPlot];
    
    // Second derivative
    CPTScatterPlot *secondPlot = [[CPTScatterPlot alloc] init];
    secondPlot.identifier    = kSecond;
    lineStyle.lineColor      = [CPTColor blueColor];
    secondPlot.dataLineStyle = lineStyle;
    secondPlot.dataSource    = self;
    
    //    [graph addPlot:secondPlot];
    
    // Auto scale the plot space to fit the plot data
    [plotSpace scaleToFitPlots:[graph allPlots]];
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    
    // Expand the ranges to put some space around the plot
    [xRange expandRangeByFactor:CPTDecimalFromDouble(1.2)];
    [yRange expandRangeByFactor:CPTDecimalFromDouble(1.2)];
    plotSpace.xRange = xRange;
    plotSpace.yRange = yRange;
    
    [xRange expandRangeByFactor:CPTDecimalFromDouble(1.025)];
    xRange.location = plotSpace.xRange.location;
    [yRange expandRangeByFactor:CPTDecimalFromDouble(1.05)];
    x.visibleAxisRange = xRange;
    y.visibleAxisRange = yRange;
    
    [xRange expandRangeByFactor:CPTDecimalFromDouble(3.0)];
    [yRange expandRangeByFactor:CPTDecimalFromDouble(3.0)];
    plotSpace.globalXRange = xRange;
    plotSpace.globalYRange = yRange;
    
    // Add plot symbols
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [[CPTColor blackColor] colorWithAlphaComponent:0.5];
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill               = [CPTFill fillWithColor:[[CPTColor blueColor] colorWithAlphaComponent:0.5]];
    plotSymbol.lineStyle          = symbolLineStyle;
    plotSymbol.size               = CGSizeMake(10.0, 10.0);
    dataSourceLinePlot.plotSymbol = plotSymbol;
    
    // Set plot delegate, to know when symbols have been touched
    // We will display an annotation when a symbol is touched
    dataSourceLinePlot.delegate                        = self;
    dataSourceLinePlot.plotSymbolMarginForHitDetection = 10.0;
    
    //增加图示
    graph.legend                 = [CPTLegend legendWithGraph:graph];
    graph.legend.numberOfRows    = 1;
    graph.legend.textStyle       = x.titleTextStyle;
    graph.legend.fill            = [CPTFill fillWithColor:[CPTColor darkGrayColor]];
    graph.legend.borderLineStyle = x.axisLineStyle;
    graph.legend.cornerRadius    = 5.0;
    graph.legend.swatchSize      = CGSizeMake(25.0, 25.0);
    graph.legendAnchor           = CPTRectAnchorBottom;
    graph.legendDisplacement     = CGPointMake(0.0, 12.0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    NSUInteger numRecords = 0;
    NSString *identifier  = (NSString *)plot.identifier;
    
    if ( [identifier isEqualToString:kData] ) {
        numRecords = self.plotData.count;
    }
    else if ( [identifier isEqualToString:kFirst] ) {
        numRecords = self.plotData1.count;
    }
    else if ( [identifier isEqualToString:kSecond] ) {
        numRecords = self.plotData2.count;
    }
    
    return numRecords;
}

-(id)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSNumber *num        = nil;
    NSString *identifier = (NSString *)plot.identifier;
    
    if ( [identifier isEqualToString:kData] ) {
        num = self.plotData[index][(fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y")];
    }
    else if ( [identifier isEqualToString:kFirst] ) {
        num = self.plotData1[index][(fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y")];
    }
    else if ( [identifier isEqualToString:kSecond] ) {
        num = self.plotData2[index][(fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y")];
    }
    
    return num;
}

#pragma mark -
#pragma mark Plot Space Delegate Methods

-(CPTPlotRange *)plotSpace:(CPTPlotSpace *)space willChangePlotRangeTo:(CPTPlotRange *)newRange forCoordinate:(CPTCoordinate)coordinate
{
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)space.graph.axisSet;
    
    CPTMutablePlotRange *changedRange = [newRange mutableCopy];
    
    switch ( coordinate ) {
        case CPTCoordinateX:
            [changedRange expandRangeByFactor:CPTDecimalFromDouble(1.025)];
            changedRange.location          = newRange.location;
            axisSet.xAxis.visibleAxisRange = changedRange;
            break;
            
        case CPTCoordinateY:
            [changedRange expandRangeByFactor:CPTDecimalFromDouble(1.05)];
            axisSet.yAxis.visibleAxisRange = changedRange;
            break;
            
        default:
            break;
    }
    
    return newRange;
}

#pragma mark -
#pragma mark CPTScatterPlot delegate methods

-(void)scatterPlot:(CPTScatterPlot *)plot plotSymbolWasSelectedAtRecordIndex:(NSUInteger)index
{
    CPTXYGraph *graph = (CPTXYGraph *)self.graph;
    
    if (self.symbolTextAnnotation) {
        [graph.plotAreaFrame.plotArea removeAnnotation:self.symbolTextAnnotation];
        self.symbolTextAnnotation = nil;
    }
    
    // Setup a style for the annotation
    CPTMutableTextStyle *hitAnnotationTextStyle = [CPTMutableTextStyle textStyle];
    hitAnnotationTextStyle.color    = [CPTColor whiteColor];
    hitAnnotationTextStyle.fontSize = 16.0;
    hitAnnotationTextStyle.fontName = @"Helvetica-Bold";
    
    // Determine point of symbol in plot coordinates
    NSDictionary *dataPoint = self.plotData[index];
    
    NSNumber *x = dataPoint[@"x"];
    NSNumber *y = dataPoint[@"y"];
    
    NSArray *anchorPoint = @[x, y];
    
    // Add annotation
    // First make a string for the y value
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
    NSString *yString = [formatter stringFromNumber:y];
    
    // Now add the annotation to the plot area
    CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:yString style:hitAnnotationTextStyle];
    CPTImage *background    = [CPTImage imageNamed:@"BlueBackground"];
    background.edgeInsets   = CPTEdgeInsetsMake(8.0, 8.0, 8.0, 8.0);
    textLayer.fill          = [CPTFill fillWithImage:background];
    textLayer.paddingLeft   = 2.0;
    textLayer.paddingTop    = 2.0;
    textLayer.paddingRight  = 2.0;
    textLayer.paddingBottom = 2.0;
    
    self.symbolTextAnnotation = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:graph.defaultPlotSpace anchorPlotPoint:anchorPoint];
    self.symbolTextAnnotation.contentLayer       = textLayer;
    self.symbolTextAnnotation.contentAnchorPoint = CGPointMake(0.5, 0.0);
    self.symbolTextAnnotation.displacement       = CGPointMake(0.0, 10.0);
    [graph.plotAreaFrame.plotArea addAnnotation:self.symbolTextAnnotation];
}

-(void)scatterPlotDataLineWasSelected:(CPTScatterPlot *)plot
{
    NSLog(@"scatterPlotDataLineWasSelected: %@", plot);
}

-(void)scatterPlotDataLineTouchDown:(CPTScatterPlot *)plot
{
    NSLog(@"scatterPlotDataLineTouchDown: %@", plot);
}

-(void)scatterPlotDataLineTouchUp:(CPTScatterPlot *)plot
{
    NSLog(@"scatterPlotDataLineTouchUp: %@", plot);
}

#pragma mark -
#pragma mark Plot area delegate method

-(void)plotAreaWasSelected:(CPTPlotArea *)plotArea
{
    NSLog(@"-(void)plotAreaWasSelected:(CPTPlotArea *)plotArea");

}


/** @brief @optional Informs the delegate that a plot area
 *  @if MacOnly was pressed. @endif
 *  @if iOSOnly touch started. @endif
 *  @param plotArea The plot area.
 **/
-(void)plotAreaTouchDown:(CPTPlotArea *)plotArea{
    // Remove the annotation
    if ( self.symbolTextAnnotation ) {
        CPTXYGraph *graph = (CPTXYGraph *)self.graph;
        
        [graph.plotAreaFrame.plotArea removeAnnotation:self.symbolTextAnnotation];
        self.symbolTextAnnotation = nil;
    }
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
