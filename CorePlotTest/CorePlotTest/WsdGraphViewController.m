//
//  WsdGraphViewController.m
//  CorePlotTest
//
//  Created by sunlight on 14-9-5.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdGraphViewController.h"

@interface WsdGraphViewController ()

@end

@implementation WsdGraphViewController

- (id)init{
    
    if (self=[super init]) {
        self.isShowDetailLabel = YES;
        CPTGraphHostingView *graphView = [[CPTGraphHostingView alloc] init];
        CPTGraph *graph = [[CPTXYGraph alloc] init];
        graphView.hostedGraph = graph;
        _graphView = graphView;
        _graph = graph;
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
    //1.设置graphViewFrame
    float height = 0.0;
    if (self.navigationController && !self.navigationController.navigationBarHidden) {
        height += 64.0;
    }
    self.graphView.frame = CGRectMake(0.0, height, self.view.bounds.size.width, self.view.bounds.size.height-height);
    self.graphView.collapsesLayers = NO;
    [self.graphView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.graphView setAutoresizesSubviews:YES];
    
    //2.设置graphView
    self.graph.frame = self.graphView.bounds;
    [self.view addSubview:self.graphView];
    
    //3.设置标题
    if ([self.delegatge respondsToSelector:@selector(genGraphTitleAfterViewDidLoad:)]) {
        self.graph.title = [self.delegatge genGraphTitleAfterViewDidLoad:self];
    }
    //4.设置其他的一些通用属性
    [self adjustCommonGraph];
    //5.代理设置graph其他属性
    if ([self.delegatge respondsToSelector:@selector(adjustGraphAfterViewDidLoad:vc:)]) {
        [self.delegatge adjustGraphAfterViewDidLoad:self.graph vc:self];
    }else{
        [self adjustDefaultGraph];
    }
    
    //6.设置图例相关属性
    if (self.graph.allPlots && self.graph.allPlots.count > 0) {
        CPTLegend *legend = [CPTLegend legendWithPlots:self.graph.allPlots];
        self.graph.legend = legend;
        if ([self.delegatge respondsToSelector:@selector(adjustGraphCPTLegend:graph:vc:)]) {
            [self.delegatge adjustGraphCPTLegend:legend graph:self.graph vc:self];
        }else{
            [self adjustDefaultLegend:legend];
        }
    }
    [self.graph reloadDataIfNeeded];
}

//创建默认的graph风格
- (void)adjustDefaultGraph{
    //1.设置标题风格
    if (self.graph.title != nil) {
        CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
        textStyle.color                = [CPTColor grayColor];
        textStyle.fontName             = @"Helvetica-Bold";
        textStyle.fontSize             = round( self.graph.bounds.size.height / CPTFloat(20.0) );
        self.graph.titleTextStyle           = textStyle;
        self.graph.titleDisplacement        = CPTPointMake( 0.0, textStyle.fontSize * CPTFloat(1.5) );
        self.graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    }
    //2.设置graph子View的frame
    CGFloat boundsPadding = round(self.graph.bounds.size.width / CPTFloat(20.0) ); // Ensure that padding falls on an integral pixel
    self.graph.paddingLeft = boundsPadding;
    if (self.graph.titleDisplacement.y > 0.0) {
        self.graph.paddingTop = self.graph.titleTextStyle.fontSize * 2.0;
    }
    else {
        self.graph.paddingTop = boundsPadding;
    }
    self.graph.paddingRight  = boundsPadding;
    self.graph.paddingBottom = boundsPadding;
    
    //3.设置绘图区域子View的边距
    self.graph.plotAreaFrame.paddingTop    = 15.0;
    self.graph.plotAreaFrame.paddingRight  = 15.0;
    self.graph.plotAreaFrame.paddingBottom = 60.0;
    self.graph.plotAreaFrame.paddingLeft   = 35.0;
    self.graph.plotAreaFrame.masksToBorder = NO;
    
}
//适配通用的属性
- (void)adjustCommonGraph{

    self.graph.plotAreaFrame.plotArea.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.设置标题的风格
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color                = [CPTColor grayColor];
    textStyle.fontName             = @"Helvetica-Bold";
    textStyle.fontSize             = 22.0;
    self.graph.titleTextStyle           = textStyle;
    self.graph.titleDisplacement        = CPTPointMake( 0.0, textStyle.fontSize * CPTFloat(1.15) );
    self.graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    //2.设置graph边距
    //设置边距
    CGFloat boundsPadding = round(self.graph.bounds.size.width / CPTFloat(20.0) ); // Ensure that padding falls on an integral pixel
    self.graph.paddingLeft = boundsPadding;
    if (self.graph.titleDisplacement.y > 0.0) {
        self.graph.paddingTop = self.graph.titleTextStyle.fontSize * 2.0;
    }
    else {
        self.graph.paddingTop = boundsPadding;
    }
    self.graph.paddingRight  = boundsPadding;
    self.graph.paddingBottom = boundsPadding;
    
    //3.设置plotAreaFrame边距
    self.graph.plotAreaFrame.paddingLeft   += 60.0;
    self.graph.plotAreaFrame.paddingTop    += 25.0;
    self.graph.plotAreaFrame.paddingRight  += 20.0;
    self.graph.plotAreaFrame.paddingBottom += 60.0;
    self.graph.plotAreaFrame.masksToBorder  = NO;
}
//创建默认的图例
- (void)adjustDefaultLegend:(CPTLegend *)legend{
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)self.graph.axisSet;
    CPTXYAxis *x          = axisSet.xAxis;
    
    legend.numberOfRows    = 1;
    legend.textStyle       = x.titleTextStyle;
    legend.fill            = [CPTFill fillWithColor:[CPTColor darkGrayColor]];
    legend.borderLineStyle = x.axisLineStyle;
    legend.cornerRadius    = 5.0;
    legend.swatchSize      = CGSizeMake(25.0, 25.0);
    self.graph.legendAnchor           = CPTRectAnchorBottom;
    self.graph.legendDisplacement     = CGPointMake(0.0, 12.0);
}

@end
