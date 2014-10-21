//
//  MoreBarViewController.m
//  CorePlotTest
//
//  Created by sunlight on 14-9-3.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MoreBarViewController.h"

@interface MoreBarViewController ()

@property (nonatomic,strong) NSArray *plotData;

@property (nonatomic,strong) NSArray *plotData2;

@end

@implementation MoreBarViewController

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
        srand((unsigned)time(0));
        for ( NSUInteger i = 0; i < 8; i++ ) {
            [contentArray addObject:@(10.0 * rand() / (double)RAND_MAX + 5.0)];
        }
        self.plotData = contentArray;
    }
    if (self.plotData2 == nil) {
        NSMutableArray *contentArray = [NSMutableArray array];
        for ( NSUInteger i = 0; i < 8; i++ ) {
            [contentArray addObject:@(10.0 * rand() / (double)RAND_MAX + 5.0)];
        }
        self.plotData2 = contentArray;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self generateData];
    
    CPTGraphHostingView *graphView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0.0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height-64.0)];
    [graphView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:graphView];
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:graphView.bounds];
    graphView.hostedGraph = graph;
    
    //设置标题
    graph.title = @"柱状图";
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color                = [CPTColor grayColor];
    textStyle.fontName             = @"Helvetica-Bold";
    textStyle.fontSize             = round( graphView.bounds.size.height / CPTFloat(20.0) );
    graph.titleTextStyle           = textStyle;
    graph.titleDisplacement        = CPTPointMake( 0.0, textStyle.fontSize * CPTFloat(1.5) );
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    
    //设置边距
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
    
    
    graph.plotAreaFrame.paddingLeft   += 60.0;
    graph.plotAreaFrame.paddingTop    += 25.0;
    graph.plotAreaFrame.paddingRight  += 20.0;
    graph.plotAreaFrame.paddingBottom += 60.0;
    graph.plotAreaFrame.masksToBorder  = NO;
    
    // Create grid line styles
    CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];
    majorGridLineStyle.lineWidth = 1.0;
    majorGridLineStyle.lineColor = [[CPTColor grayColor] colorWithAlphaComponent:0.75];
    
    CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
    minorGridLineStyle.lineWidth = 1.0;
    minorGridLineStyle.lineColor = [[CPTColor grayColor] colorWithAlphaComponent:0.25];
    
    // Create axes
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x          = axisSet.xAxis;
    {
        x.majorIntervalLength         = CPTDecimalFromInteger(1);
        x.orthogonalCoordinateDecimal = CPTDecimalFromInteger(0);
        x.majorGridLineStyle          = majorGridLineStyle;
        x.minorGridLineStyle          = minorGridLineStyle;
        x.axisLineStyle               = nil;
        x.majorTickLineStyle          = nil;
        x.minorTickLineStyle          = nil;
        //如果将labelFormate设置为nil,则坐标的值不会画出来
        NSNumberFormatter *formate = [[NSNumberFormatter alloc] init];
        formate.maximumFractionDigits = 0;
        x.labelFormatter              = formate;
        x.labelOffset                 = 10.0;
        x.labelingPolicy = CPTAxisLabelingPolicyFixedInterval;
        
        x.title       = @"X Axis";
        x.titleOffset = 30.0;
        //利用axisLabels属性可以动态设置坐标轴显示
        //x.axisLabels = customLabels;
        
    }
    
    CPTXYAxis *y = axisSet.yAxis;
    {
        y.majorIntervalLength         = CPTDecimalFromInteger(10);
        y.minorTicksPerInterval       = 9;
        y.axisConstraints             = [CPTConstraints constraintWithLowerOffset:0.0];
        y.preferredNumberOfMajorTicks = 8;
        y.majorGridLineStyle          = majorGridLineStyle;
        y.minorGridLineStyle          = minorGridLineStyle;
        y.axisLineStyle               = nil;
        y.majorTickLineStyle          = nil;
        y.minorTickLineStyle          = nil;
        y.labelOffset                 = 10.0;
        //y.labelRotation               = M_PI_2;
        y.labelingPolicy              = CPTAxisLabelingPolicyAutomatic;
        
        y.title       = @"Y Axis";
        y.titleOffset = 30.0;
    }
    graph.axisSet.axes = @[x, y];
    
    // Create a bar line style
    CPTMutableLineStyle *barLineStyle = [[CPTMutableLineStyle alloc] init];
    barLineStyle.lineWidth = 1.0;
    barLineStyle.lineColor = [CPTColor whiteColor];
    
    // Create bar plot
    CPTBarPlot *barPlot = [[CPTBarPlot alloc] init];
    barPlot.lineStyle         = barLineStyle;
    barPlot.barWidth          = CPTDecimalFromFloat(0.25); // bar is 75% of the available space
    barPlot.barCornerRadius   = 4.0;
    barPlot.barsAreHorizontal = NO;
    barPlot.dataSource        = self;
    barPlot.identifier        = @"plot1";
    barPlot.barOffset = CPTDecimalFromDouble(-[[[NSDecimalNumber alloc] initWithDecimal:barPlot.barWidth] doubleValue]/2.0);
    [graph addPlot:barPlot];
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(16)];
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-0.5) length:CPTDecimalFromFloat(8)];
    
    // Plot space
    //CPTMutablePlotRange *barRange = [[barPlot plotRangeEnclosingBars] mutableCopy];
    //[barRange expandRangeByFactor:CPTDecimalFromDouble(1.1)];
    
    //CPTXYPlotSpace *barPlotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    //barPlotSpace.xRange = barRange;
    //barPlotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(16.0f)];
    
    
    CPTBarPlot *barplot2 = [[CPTBarPlot alloc] init];
    barplot2.identifier = @"plot2";
    barplot2.barCornerRadius = 4.0;
    //barplot2.opacity = 0.9;
    barplot2.barsAreHorizontal = NO;
    barplot2.delegate = self;
    barplot2.dataSource = self;
    barplot2.lineStyle = barLineStyle;
    barplot2.barWidth = CPTDecimalFromDouble(0.25);
    barplot2.barOffset = CPTDecimalFromDouble(CPTDecimalDoubleValue(barplot2.barWidth)/2.0);
    [graph addPlot:barplot2];
    
    
    
    //图例
    // Add legend
    CPTLegend *theLegend = [CPTLegend legendWithGraph:graph];
    theLegend.fill            = [CPTFill fillWithColor:[CPTColor colorWithGenericGray:0.15]];
    theLegend.borderLineStyle = barLineStyle;
    theLegend.cornerRadius    = 10.0;
    theLegend.swatchSize      = CGSizeMake(16.0, 16.0);
    CPTMutableTextStyle *whiteTextStyle = [CPTMutableTextStyle textStyle];
    whiteTextStyle.color    = [CPTColor whiteColor];
    whiteTextStyle.fontSize = 12.0;
    theLegend.textStyle     = whiteTextStyle;
    theLegend.rowMargin     = 10.0;
    theLegend.numberOfRows  = 1;
    theLegend.paddingLeft   = 12.0;
    theLegend.paddingTop    = 12.0;
    theLegend.paddingRight  = 12.0;
    theLegend.paddingBottom = 12.0;
    
    graph.legend             = theLegend;
    graph.legendAnchor       = CPTRectAnchorBottom;
    graph.legendDisplacement = CGPointMake(0.0, 5.0);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Plot Data Delegate Methods
-(void)barPlot:(CPTBarPlot *)plot barWasSelectedAtRecordIndex:(NSUInteger)idx{

    NSLog(@"%d",idx);
}
-(void)barPlot:(CPTBarPlot *)plot barWasSelectedAtRecordIndex:(NSUInteger)idx withEvent:(CPTNativeEvent *)event{
    NSLog(@"event%d",idx);
}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return self.plotData.count;
}

-(NSArray *)numbersForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndexRange:(NSRange)indexRange
{
    NSArray *nums = nil;
    
    switch ( fieldEnum ) {
        case CPTBarPlotFieldBarLocation:
            nums = [NSMutableArray arrayWithCapacity:indexRange.length];
            for ( NSUInteger i = indexRange.location; i < NSMaxRange(indexRange); i++ ) {
                [(NSMutableArray *)nums addObject : @(i)];
            }
            break;
            
        case CPTBarPlotFieldBarTip:
            if ([plot.identifier isEqual:@"plot1"]) {
                nums = [self.plotData objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:indexRange]];
            }else{
                nums = [self.plotData2 objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:indexRange]];
            }
            break;
            
        default:
            break;
    }
    
    return nums;
}

-(CPTFill *)barFillForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index
{
    CPTColor *color = nil;
    
    switch ( index ) {
        case 0:
            color = [CPTColor redColor];
            break;
            
        case 1:
            color = [CPTColor greenColor];
            break;
            
        case 2:
            color = [CPTColor blueColor];
            break;
            
        case 3:
            color = [CPTColor yellowColor];
            break;
            
        case 4:
            color = [CPTColor purpleColor];
            break;
            
        case 5:
            color = [CPTColor cyanColor];
            break;
            
        case 6:
            color = [CPTColor orangeColor];
            break;
            
        case 7:
            color = [CPTColor magentaColor];
            break;
            
        default:
            break;
    }
    CPTGradient *fillGradient = [CPTGradient gradientWithBeginningColor:color endingColor:[[CPTColor blackColor] colorWithAlphaComponent:0.9]];
    
    return [CPTFill fillWithGradient:fillGradient];
}

//图示的标题
-(NSString *)legendTitleForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index
{
    //如果不要显示图例--这里返回nil即可
    if ([barPlot.identifier isEqual:@"plot2"]) {
        return  nil;
    }
    
    return [NSString stringWithFormat:@"Bar %lu", (unsigned long)(index + 1)];
}
//数据label
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)idx{
    
    CPTMutableTextStyle *textStyle = [[CPTMutableTextStyle alloc] init];
    textStyle.fontName = [[UIFont familyNames] firstObject];
    textStyle.fontSize = 12.0;
    textStyle.color = [CPTColor blueColor];
    
    if ([plot.identifier isEqual:@"plot1"]) {
            textStyle.color = [CPTColor blueColor];
        return [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%.1f",[self.plotData[idx] doubleValue]] style:textStyle];
    }else{
            textStyle.color = [CPTColor redColor];
        return [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%.1f",[self.plotData2[idx] doubleValue]] style:textStyle];
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
