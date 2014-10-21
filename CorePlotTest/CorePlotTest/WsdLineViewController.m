//
//  WsdLineViewController.m
//  CorePlotTest
//
//  Created by sunlight on 14-9-5.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdLineViewController.h"

@interface WsdLineViewController ()

@property (nonatomic,strong) NSMutableDictionary *plotDic;
@property (nonatomic,strong) NSMutableDictionary *plotDataDic;
//平行线的Identify集合
@property (nonatomic,strong) NSMutableArray *parallelIdentifies;
@property (nonatomic,assign) NSInteger xCounts;

@end

@implementation WsdLineViewController

- (id)init{
    
    if (self=[super init]) {
        self.plotDataDic = [[NSMutableDictionary alloc] init];
        self.plotDic = [[NSMutableDictionary alloc] init];
        self.parallelIdentifies = [[NSMutableArray alloc] init];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}


#pragma mark 公有方法
//增加一条曲线
- (void)addLineForData:(NSArray *)plotData identify:(NSString*)identify lineStyle:(CPTLineStyle *)lineStyle interpolation:(CPTScatterPlotInterpolation)interpolation symbol:(CPTPlotSymbol *)plotSymbol {

    if (identify && ![identify isEqualToString:@""]) {
    
        CPTScatterPlot *linePlot = [[CPTScatterPlot alloc] init];
        linePlot.identifier = identify;
        linePlot.dataLineStyle = lineStyle;
        linePlot.dataSource = self;
        linePlot.plotSymbol = plotSymbol;
        linePlot.interpolation = interpolation;
        [self.graph addPlot:linePlot];
        [self.plotDataDic setObject:plotData forKey:identify];
        self.xCounts = [plotData count];
    
    }
}
//增加一条平行线
- (void)addParallelLineForData:(double)lineData identify:(NSString*)identify lineStyle:(CPTLineStyle *)lineStyle{
    
    if (identify && ![identify isEqualToString:@""]) {
        CPTScatterPlot *centerLinePlot = [[CPTScatterPlot alloc] init];
        centerLinePlot.identifier = identify;
        centerLinePlot.dataLineStyle = lineStyle;
        centerLinePlot.dataSource = self;
        [self.graph addPlot:centerLinePlot];
        
        [self.plotDataDic setObject:@(lineData) forKey:identify];
        [self.parallelIdentifies addObject:identify];
        if (self.xCounts == 0) {
            self.xCounts = 2;
        }
    }
}
#pragma mark CPTScatterPlotDataSource datasource
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    
    if ([self.parallelIdentifies containsObject:plot.identifier]) {
        
        return 2;
    }else{
        
        return [[self.plotDataDic objectForKey:plot.identifier] count];
    }
}
-(double)doubleForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx{
    double value = 0.0;
    
    switch ( fieldEnum ) {
        case CPTScatterPlotFieldX:{
            if ([self.parallelIdentifies containsObject:plot.identifier]) {
                switch (idx) {
                    case 0:{
                        value = 0.0;
                    }
                        break;
                    case 1:{
                        value = self.xCounts-1;
                    }
                        break;
                    default:
                        break;
                }
            }else{
                value = idx;
            }
        }
            break;
        case CPTScatterPlotFieldY:{
            if ([self.parallelIdentifies containsObject:plot.identifier]) {
                value = [[self.plotDataDic objectForKey:plot.identifier] doubleValue];
            }else{
                value = [[self.plotDataDic objectForKey:plot.identifier][idx] doubleValue];
            }
        }
            break;
        default:
            break;
    }
    return value;
}
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)idx{
    
    if (self.isShowDetailLabel) {
        if (![self.parallelIdentifies containsObject:plot.identifier]) {
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
            CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%.1f",[[self.plotDataDic objectForKey:plot.identifier][idx] doubleValue]] style:textStyle];
            return textLayer;
        }

    }
    return nil;
}
@end
