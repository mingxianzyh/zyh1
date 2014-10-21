//
//  SingleCureLineViewController.m
//  MPPlotTest
//
//  Created by sunlight on 14-8-28.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "SingleCureLineViewController.h"

@interface SingleCureLineViewController ()

@end

@implementation SingleCureLineViewController

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
    self.navigationItem.title = @"单折线(圆滑)";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createBrokenLine];
}
- (void)createBrokenLine{
    
    MPGraphView *graphView = [MPPlot plotWithType:MPPlotTypeGraph frame:CGRectMake(0.0, 64.0, 1024.0, 768.0-64.0)];
    graphView.delegate = self;
    graphView.axisColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    //X轴均分(包含两个空格)
    //Y轴的Min与Max
    MPGraphValuesRange range = MPGraphValuesRangeMake(0, 8);
    graphView.valueRanges = range;
    //线条的颜色
    //点击明细的背景颜色
    graphView.detailBackgroundColor=[UIColor colorWithRed:0.444 green:0.842 blue:1.000 alpha:1.000];
    [self.view addSubview:graphView];
    
}
//每一条线对应的填充渐变颜色(不实现,或者返回为nil表示不填充)
- (NSArray *)gradientFillColorsForLineIndex:(NSInteger)index{
    
    return @[[UIColor colorWithRed:0.251 green:0.232 blue:1.000 alpha:1.0],[UIColor colorWithRed:0.251 green:0.232 blue:1.000 alpha:0.5],[UIColor colorWithRed:0.251 green:0.232 blue:1.000 alpha:0.1]];
}
//每一条线对应的点的大小
//- (CGSize)sizeOfDotAtLineIndex:(NSInteger)index
//每一条线是否显示数据明细
//- (BOOL)isShowDetailAtLineIndex:(NSInteger)index;
//每一条曲线是否圆滑
- (BOOL)isCurveAtLineIndex:(NSInteger)index{
    return YES;
}
//每条曲线圆滑的精度
- (float)curveGranularityForLineIndex:(NSInteger)index{
    return 20.0;
}
//每一条线对应的点的颜色
- (UIColor *)colorOfDotAtLineIndex:(NSInteger)index{
    
    return [UIColor blackColor];
}
//每一条线本身的颜色
- (UIColor *)colorOfLineAtLineIndex:(NSInteger)index{
    
    return [UIColor redColor];
}
//每一条线的线宽
- (float)lineWidthForLineIndex:(NSInteger)index{
    return 2.0;
}

//X的标题 0是否指原点由isOriginAtX决定
- (NSString *)titleOfXcale:(NSInteger)xIndex{
    return [NSString stringWithFormat:@"%d 月",xIndex];
}

//获取Y轴刻度总个数
- (NSInteger)numbersOfYScales:(MPPlot *)plot{
    return 9;
}
- (NSInteger)numbersOfLines{
    return 1;
}
- (NSArray *)valuesForLineIndex:(NSInteger)index{
    
    return @[@2.5,@2.6,@2.8,@3,@3.3,@3,@3.6,@3.8,@3.2,@3.6,@4,@4.5];
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
