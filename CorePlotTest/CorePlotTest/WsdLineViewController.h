//
//  WsdLineViewController.h
//  CorePlotTest
//
//  Created by sunlight on 14-9-5.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WsdGraphViewController.h"

@class WsdLineViewController;
@protocol WsdLineViewControllerDelegate <WsdGraphViewControllerDelegate>


@end
//如果图形细节不符合要求,可以自定义
@interface WsdLineViewController : WsdGraphViewController<CPTPlotAreaDelegate,CPTScatterPlotDataSource>

@property (nonatomic,assign) BOOL isFirstBlank;

//增加一条曲线
- (void)addLineForData:(NSArray *)plotData identify:(NSString*)identify lineStyle:(CPTLineStyle *)lineStyle interpolation:(CPTScatterPlotInterpolation)interpolation symbol:(CPTPlotSymbol *)plotSymbol ;
//增加一条平行线
- (void)addParallelLineForData:(double)lineData identify:(NSString*)identify lineStyle:(CPTLineStyle *)lineStyle;
@end
