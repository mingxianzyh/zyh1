//
//  MainViewController.m
//  CorePlotTest
//
//  Created by sunlight on 14-8-29.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//
#import "MainViewController.h"
#import "ControlLineViewController.h"
#import "AxisViewController.h"
#import "CurveScatterViewController.h"
#import "ColoredBarCharViewController.h"
#import "MoreBarViewController.h"
#import "PieViewController.h"



@interface MainViewController ()

@property (nonatomic,strong) UIViewController *mainVC;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) WsdLineViewController *lineVC;
@property (nonatomic,strong) WsdBarViewController *barVC;

@end

@implementation MainViewController

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
    [self generateData];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (void)generateData{
    AxisViewController *a = [[AxisViewController alloc] init];
    ControlLineViewController *cl = [[ControlLineViewController alloc] init];
    CurveScatterViewController *cs = [[CurveScatterViewController alloc] init];
    ColoredBarCharViewController *cbc = [[ColoredBarCharViewController alloc] init];
    MoreBarViewController *mb = [[MoreBarViewController alloc] init];
    PieViewController *pie = [[PieViewController alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:a];
    [array addObject:cl];
    [array addObject:cs];
    [array addObject:cbc];
    [array addObject:mb];
    [array addObject:pie];
    //加入WsdLineVC
    WsdLineViewController *lineVC = [[WsdLineViewController alloc] init];
    lineVC.delegatge = self;
    
    CPTMutableLineStyle *lineStyle = [[CPTMutableLineStyle alloc] init];
    lineStyle.lineWidth = 2.0;
    lineStyle.lineColor = [CPTColor redColor];
    //加入平行线
    [lineVC addParallelLineForData:13.0 identify:@"测试" lineStyle:lineStyle];
    CPTMutableLineStyle *lineStyle2 = [[CPTMutableLineStyle alloc] init];
    lineStyle2.lineWidth = 2.0;
    lineStyle2.lineColor = [CPTColor lightGrayColor];
    
    //加入折线
    [lineVC addLineForData:@[@(6.0),@(6.8),@(4.3),@(3.2),@(9.2),@(10.2),@(19.2),@(9.2),@(6.5)] identify:@"测试2" lineStyle:lineStyle2 interpolation:CPTScatterPlotInterpolationCurved symbol:nil];
    [array addObject:lineVC];
    self.lineVC = lineVC;
    
    //加入bar控制器
    WsdBarViewController *barVC=[[WsdBarViewController alloc] init];
    barVC.delegatge = self;
    CPTMutableLineStyle *whiteLineStyle = [[CPTMutableLineStyle alloc] init];
    whiteLineStyle.lineColor = [CPTColor clearColor];
    whiteLineStyle.lineWidth = 1.0;
    [barVC addBarForData:@[@(6.0),@(6.8),@(4.3),@(3.2),@(9.2),@(10.2),@(19.2)] identify:@"北京" lineStyle:whiteLineStyle];
    //[barVC addBarForData:@[@(6.0),@(6.8),@(4.3),@(3.2),@(9.2),@(10.2),@(19.2)] identify:@"上海" lineStyle:whiteLineStyle];
    //[barVC addBarForData:@[@(6.0),@(6.8),@(4.3),@(3.2),@(9.2),@(10.2),@(19.2)] identify:@"上海1" lineStyle:whiteLineStyle];
    //[barVC addBarForData:@[@(6.0),@(6.8),@(4.3),@(3.2),@(9.2),@(10.2),@(19.2)] identify:@"上海1" lineStyle:whiteLineStyle];
    [array addObject:barVC];
    self.barVC = barVC;
    
    self.dataArray = [NSArray arrayWithArray:array];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *IDENTIFY = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFY];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"坐标轴";
        }
            break;
        case 1:{
            cell.textLabel.text = @"折线一";
        }
            break;
        case 2:{
            cell.textLabel.text = @"折线二(圆滑)";
        }
            break;
        case 3:{
            cell.textLabel.text = @"柱状图一";
        }
            break;
        case 4:{
            cell.textLabel.text = @"柱状图二(比较)";
        }
            break;
        case 5:{
            cell.textLabel.text = @"饼状图";
        }
            break;
        case 6:{
            cell.textLabel.text = @"测试1";
        }
        case 7:{
            cell.textLabel.text = @"测试2";
        }
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark WsdBar delegate
//设置每个Bar的颜色,不同的bar Identify不一致
-(CPTColor *)barColorForBarIdentify:(NSString *)identify recordIndex:(NSUInteger)index vc:(UIViewController *)vc{
    if (self.barVC == vc) {
        if ([identify isEqualToString:@"北京"]) {
            return [CPTColor redColor];
        }else if([identify isEqualToString:@"上海"]){
            return [CPTColor greenColor];
        }else{
            return [CPTColor cyanColor];
        }
    }else{

    }
    return nil;
}
//设置每个bar的legend title,不同的bar Identify不一致
-(NSString *)legendTitleForBarIdentify:(NSString *)identify recordIndex:(NSUInteger)index vc:(UIViewController *)vc{
    if (self.barVC == vc) {
        if (index == 0) {
            return identify;
        }
    }
    return nil;
}


//设置graph的标题
- (NSString *)genGraphTitleAfterViewDidLoad:(UIViewController*)vc{

    if (vc == self.lineVC) {
        return @"WsdLine测试";
    }else if(vc == self.barVC){
        return @"WsdBar测试";
    }else{
        return nil;
    }
}

//设置标题属性,区域,xy轴设置等其他设置,设置graph
- (void)adjustGraphAfterViewDidLoad:(CPTGraph *)graph vc:(UIViewController*)vc{
    
    if (vc == self.lineVC) {
        //1.设置标题属性
        CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
        textStyle.color                = [CPTColor grayColor];
        textStyle.fontName             = @"Helvetica-Bold";
        textStyle.fontSize             = 22.0;
        graph.titleTextStyle           = textStyle;
        graph.titleDisplacement        = CPTPointMake( 0.0, textStyle.fontSize * CPTFloat(1.15) );
        graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
        
        //2.设置graph的边距
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
        CPTXYAxis *x = axisSet.xAxis;
        //两个主刻度之间多少个小刻度
        x.minorTicksPerInterval = 0;
        
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
        y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0);
        y.labelingPolicy     = CPTAxisLabelingPolicyAutomatic;
        y.minorTicksPerInterval = 4;
        y.majorGridLineStyle = majorGridLineStyle;
        y.minorGridLineStyle = minorGridLineStyle;
        y.labelFormatter     = labelFormatter;
        y.title       = @"数据";
        y.titleOffset = 30.0;
        
        CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
        plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0) length:CPTDecimalFromDouble(10.0)];
        plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0) length:CPTDecimalFromDouble(20)];
        CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
        CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
        //下面这种方式可以去除过长的坐标轴和指示线
        //设置gridLine的边界
        x.gridLinesRange = yRange;
        y.gridLinesRange = xRange;
        //设置坐标轴的可见边界
        x.visibleRange = xRange;
        y.visibleRange = yRange;
        //X轴拉伸 避免边界圆点显示不全
        [xRange expandRangeByFactor:CPTDecimalFromDouble(1.1)];
        [yRange expandRangeByFactor:CPTDecimalFromDouble(1.1)];
        plotSpace.xRange = xRange;
        plotSpace.yRange = yRange;
    }else if(vc == self.barVC){
        
        CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
        textStyle.color                = [CPTColor grayColor];
        textStyle.fontName             = @"Helvetica-Bold";
        textStyle.fontSize             = 22.0;
        graph.titleTextStyle           = textStyle;
        graph.titleDisplacement        = CPTPointMake( 0.0, textStyle.fontSize * CPTFloat(1.15) );
        graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
        
        //设置边距
        CGFloat boundsPadding = round(graph.bounds.size.width / CPTFloat(20.0) ); // Ensure that padding falls on an integral pixel
        graph.paddingLeft = boundsPadding;
        if ( graph.titleDisplacement.y > 0.0 ) {
            graph.paddingTop = graph.titleTextStyle.fontSize * 2.0;
        }
        else {
            graph.paddingTop = boundsPadding;
        }
        graph.paddingRight  = boundsPadding;
        graph.paddingBottom = boundsPadding;
        
        
        //graph.plotAreaFrame.paddingLeft   += 60.0;
        //graph.plotAreaFrame.paddingTop    += 25.0;
        //graph.plotAreaFrame.paddingRight  += 20.0;
        //graph.plotAreaFrame.paddingBottom += 60.0;
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
        
        CPTXYAxis *y = axisSet.yAxis;
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
        y.title       = @"消费量";
        y.titleOffset = 50.0;
        
        graph.axisSet.axes = @[x, y];
        
        // Create a bar line style
        CPTMutableLineStyle *barLineStyle = [[CPTMutableLineStyle alloc] init];
        barLineStyle.lineWidth = 1.0;
        barLineStyle.lineColor = [CPTColor whiteColor];
        
        CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
        plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(20.0)];
        plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-0.5) length:CPTDecimalFromFloat(7.0)];
    }
}

//设置图例相关属性
- (void)adjustGraphCPTLegend:(CPTLegend *)legend graph:(CPTGraph *)graph vc:(UIViewController*)vc{
    if (self.lineVC == vc) {
        //1.设置legend的的textStyle
        //2.设置legend的numberOfRows
        //3.设置legend的fill
        //4.设置legend的borderLineStyle
        //5.设置legend的cornerRadius
        //6.设置legend的swatchSize
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
    }else if(self.barVC == vc){
        
        CPTMutableLineStyle *lineStyle = [[CPTMutableLineStyle alloc] init];
        lineStyle.lineColor = [CPTColor blackColor];
        legend.fill            = [CPTFill fillWithColor:[CPTColor colorWithGenericGray:0.15]];
        legend.borderLineStyle = lineStyle;
        legend.cornerRadius    = 10.0;
        legend.swatchSize      = CGSizeMake(16.0, 16.0);
        CPTMutableTextStyle *whiteTextStyle = [CPTMutableTextStyle textStyle];
        whiteTextStyle.color    = [CPTColor whiteColor];
        whiteTextStyle.fontSize = 12.0;
        legend.textStyle     = whiteTextStyle;
        legend.rowMargin     = 10.0;
        legend.numberOfRows  = 1;
        legend.paddingLeft   = 12.0;
        legend.paddingTop    = 12.0;
        legend.paddingRight  = 12.0;
        legend.paddingBottom = 12.0;
        
        graph.legendAnchor       = CPTRectAnchorBottom;
        graph.legendDisplacement = CGPointMake(0.0, 5.0);
    }
}
- (CPTTextStyle *)textStyleForDetailLabelIdentify:(NSString *)identify vc:(UIViewController*)vc{
    if (self.lineVC == vc) {
        
        CPTMutableTextStyle *textStyle = [[CPTMutableTextStyle alloc] init];
        textStyle.color = [CPTColor redColor];
        textStyle.fontSize = 16.0;
        return textStyle;
        
    }else if(self.barVC == vc){
        
        CPTMutableTextStyle *textStyle = [[CPTMutableTextStyle alloc] init];
        textStyle.color = [CPTColor redColor];
        textStyle.fontSize = 10.0;
        return textStyle;
        
    }
    return nil;
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
