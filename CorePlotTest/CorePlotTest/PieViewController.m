//
//  PieViewController.m
//  CorePlotTest
//
//  Created by sunlight on 14-9-3.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "PieViewController.h"

@interface PieViewController ()

@property (nonatomic,strong) NSArray *plotData;
@property (nonatomic,strong) NSMutableArray *selectIndexs;

@end

@implementation PieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)generateData{

    if (!self.plotData) {
        self.plotData = @[@20,@30,@50];
        self.selectIndexs = [[NSMutableArray alloc] init];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self generateData];
    // Do any additional setup after loading the view.
    CPTGraphHostingView *graphView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0.0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height-64.0)];
    graphView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:graphView];
    
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:graphView.bounds];
    graphView.hostedGraph = graph;
    graph.title = @"饼状图";
    CPTMutableTextStyle *titleTextStyle = [[CPTMutableTextStyle alloc] init];
    titleTextStyle.fontSize = 20.0;
    graph.titleTextStyle = titleTextStyle;
    graph.paddingTop = 50.0;
    
    CPTGradient *overlayGradient = [[CPTGradient alloc] init];
    overlayGradient.gradientType = CPTGradientTypeRadial;
    overlayGradient              = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.0] atPosition:0.0];
    overlayGradient              = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.3] atPosition:0.95];
    overlayGradient              = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.7] atPosition:1.0];
    
    
    CPTPieChart *pieChar = [[CPTPieChart alloc] initWithFrame:graphView.bounds];
    
    /*
    CPTMutableLineStyle *lineStyle = [[CPTMutableLineStyle alloc] init];
    lineStyle.lineWidth = 1.0;
    lineStyle.lineColor = [CPTColor blackColor];
    pieChar.borderLineStyle = lineStyle;
    */
    
    pieChar.dataSource = self;
    pieChar.delegate = self;
    pieChar.identifier = @"pieChar";
    //饼图的半径
    pieChar.pieRadius = self.view.bounds.size.height > self.view.bounds.size.width ? self.view.bounds.size.width/2.5 : self.view.bounds.size.height/2.5;
    //饼图的切割方向(顺时针/逆时针)
    pieChar.sliceDirection = CPTPieDirectionCounterClockwise;
    //渐变悬浮颜色
    pieChar.overlayFill    = [CPTFill fillWithGradient:overlayGradient];
    //绘图起始点的旋转角度
    //pieChar.startAngle = M_PI_2;
    pieChar.labelOffset = -100.0;
    //NO 相对于坐标轴  YES 相对于饼图中心点
    pieChar.labelRotationRelativeToRadius = YES;
    //内圆的半径
    pieChar.pieInnerRadius = 50.0;
    [graph addPlot:pieChar];
    
    
    CPTLegend *legend = [CPTLegend legendWithGraph:graph];
    legend.fill = [CPTFill fillWithColor:[CPTColor whiteColor]];
    legend.borderLineStyle = [CPTLineStyle lineStyle];
    legend.numberOfRows = 1;
    
    graph.legend = legend;
    graph.legendAnchor = CPTRectAnchorBottom;
    graph.legendDisplacement = CGPointMake(0.0, 20.0);
}

#pragma mark plot datasource
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    
    return [self.plotData count];
}
-(id)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx{

    if (fieldEnum == CPTPieChartFieldSliceWidth) {
        return self.plotData[idx];
    }else{
    
        NSLog(@"%d",fieldEnum);
        return @(idx);
    }

}
-(CPTFill *)sliceFillForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)idx{
    CPTColor *color = [CPTColor redColor];
    switch (idx) {
        case 0:{
            color = [CPTColor greenColor];
        }
            break;
        case 1:{
            color = [CPTColor yellowColor];
        }
            break;
        case 2:{
            color = [CPTColor cyanColor];
        }
            break;
            
        default:
            break;
    }
    return [CPTFill fillWithColor:color];
}
//偏移的半径
-(CGFloat)radialOffsetForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)idx{
    float radial = 0.0;
    if ([self.selectIndexs containsObject:@(idx)]) {
        radial = 20.0;
    }
    return radial;
}
-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)idx{
    return [NSString stringWithFormat:@"饼图%d",idx];
}
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    static CPTMutableTextStyle *text = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        text = [[CPTMutableTextStyle alloc] init];
        text.color = [CPTColor whiteColor];
        text.fontSize = 30.0;
    });
    
    CPTTextLayer *newLayer = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%1.0f", [self.plotData[index] floatValue]]
                                                          style:text];
    return newLayer;
}
#pragma mark delegate
-(void)pieChart:(CPTPieChart *)plot sliceWasSelectedAtRecordIndex:(NSUInteger)idx{
    if ([self.selectIndexs containsObject:@(idx)]) {
        [self.selectIndexs removeObject:@(idx)];
    }else{
          [self.selectIndexs addObject:@(idx)];
    }
    [plot reloadData];
    /*
    [UIView animateWithDuration:1.0 animations:^{
         [plot reloadData];
    }];
     */
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
