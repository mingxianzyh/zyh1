//
//  WsdBarViewController.h
//  CorePlotTest
//
//  Created by sunlight on 14-9-9.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdGraphViewController.h"

@protocol WsdBarViewControllerDelegate <WsdGraphViewControllerDelegate>
//设置每个Bar的颜色,不同的bar Identify不一致
-(CPTColor *)barColorForBarIdentify:(NSString *)identify recordIndex:(NSUInteger)index vc:(UIViewController *)vc;
//设置每个bar的legend title,不同的bar Identify不一致
-(NSString *)legendTitleForBarIdentify:(NSString *)identify recordIndex:(NSUInteger)index vc:(UIViewController *)vc;
@end

@interface WsdBarViewController : WsdGraphViewController<CPTBarPlotDataSource>
//增加一个bar
- (void)addBarForData:(NSArray *)plotData identify:(NSString*)identify lineStyle:(CPTLineStyle *)lineStyle;

@end
