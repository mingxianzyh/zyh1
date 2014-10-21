//
//  WsdBarViewController.m
//  CorePlotTest
//
//  Created by sunlight on 14-9-9.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdBarViewController.h"


@interface  WsdBarViewController()

@property (nonatomic,strong) NSMutableDictionary *barDataDic;
@end
@implementation WsdBarViewController

- (id)init{
    
    self = [super init];
    if (self) {
        self.barDataDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //调整bar的宽度以及位置
    NSArray *plots = self.graph.allPlots;
    NSInteger count = [plots count];
    if (count == 1) {
        CPTBarPlot *barPlot = [plots lastObject];
        barPlot.barWidth = CPTDecimalFromDouble(0.5);
    }else if(count > 1){
        double middle = count/2.0;
        float widthScale = 1.0/(count*2.0);
        for (int i = 0 ; i < count ; i++) {
            CPTBarPlot *barPlot = plots[i];
            barPlot.barWidth = CPTDecimalFromDouble(widthScale);
            //表示中心点距离主刻度坐标的位置
            barPlot.barOffset = CPTDecimalFromDouble(widthScale*(i-middle)+widthScale/2.0);
        }
    }
}


#pragma mark CPTPlotDataSource datasource
//每个plot有多少个数据
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    
    return [[self.barDataDic objectForKey:plot.identifier] count];
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
            
            nums = [[self.barDataDic objectForKey:plot.identifier] objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:indexRange]];
            
            break;
            
        default:
            break;
    }
    
    return nums;
}
//bar 的颜色
-(CPTFill *)barFillForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index
{
    CPTColor *color = nil;
    id<WsdBarViewControllerDelegate> barDelegate = (id<WsdBarViewControllerDelegate>)self.delegatge;
    if ([barDelegate respondsToSelector:@selector(barColorForBarIdentify:recordIndex:vc:)]) {

        color = [barDelegate barColorForBarIdentify:(NSString *)barPlot.identifier recordIndex:index vc:self];
    }
    if (!color) {
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
    }
    CPTGradient *fillGradient = [CPTGradient gradientWithBeginningColor:color endingColor:[[CPTColor blackColor] colorWithAlphaComponent:0.9]];
    
    return [CPTFill fillWithGradient:fillGradient];
}
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)idx{
    
    if (self.isShowDetailLabel) {
        static CPTTextStyle *textStyle ;
        if (!textStyle) {
            if ([self.delegatge respondsToSelector:@selector(textStyleForDetailLabelIdentify:vc:)]) {
                textStyle = [self.delegatge textStyleForDetailLabelIdentify:(NSString *)plot.identifier vc:self];
                if (!textStyle) {
                    CPTMutableTextStyle *textMutableStyle = [[CPTMutableTextStyle alloc] init];
                    textMutableStyle.fontName = [[UIFont familyNames] firstObject];
                    textMutableStyle.fontSize = 12.0;
                    textMutableStyle.color = [CPTColor blackColor];
                    textStyle = textMutableStyle;
                }
            }else{
                CPTMutableTextStyle *textMutableStyle = [[CPTMutableTextStyle alloc] init];
                textMutableStyle.fontName = [[UIFont familyNames] firstObject];
                textMutableStyle.fontSize = 12.0;
                textMutableStyle.color = [CPTColor blackColor];
                textStyle = textMutableStyle;
            }
        }
        CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%.1f",[[self.barDataDic objectForKey:plot.identifier][idx] doubleValue]] style:textStyle];
        return textLayer;
    }
    
    return nil;
}

//图示的标题
-(NSString *)legendTitleForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index
{
    
    NSString *legendTitle = nil;
    id<WsdBarViewControllerDelegate> barDelegate = (id<WsdBarViewControllerDelegate>)self.delegatge;
    if ([barDelegate respondsToSelector:@selector(legendTitleForBarIdentify:recordIndex:vc:)]) {
        legendTitle = [barDelegate legendTitleForBarIdentify:(NSString *)barPlot.identifier recordIndex:index vc:self];
    }else{
        legendTitle = [NSString stringWithFormat:@"Bar%lu", (unsigned long)(index + 1)];
    }

    return legendTitle;
}
#pragma mark 公有方法
//增加一个bar
- (void)addBarForData:(NSArray *)plotData identify:(NSString*)identify lineStyle:(CPTLineStyle *)lineStyle{
    
    if (identify && ![identify isEqualToString:@""]) {
        CPTBarPlot *barPlot = [[CPTBarPlot alloc] init];
        barPlot.identifier = identify;
        barPlot.lineStyle = lineStyle;
        barPlot.barsAreHorizontal = NO;
        barPlot.barCornerRadius   = 4.0;
        barPlot.dataSource = self;
        [self.graph addPlot:barPlot];
        [self.barDataDic setObject:plotData forKey:identify];
    }
}

@end
