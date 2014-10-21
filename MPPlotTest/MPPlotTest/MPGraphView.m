//
//  MPGraphView.m
//
//
//  Created by Alex Manzella on 18/05/14.
//  Copyright (c) 2014 mpow. All rights reserved.
//
#define kDefaultLineWidth 2.5
#define kDefaultLineColor [UIColor blueColor]

#import "MPGraphView.h"
#import "UIBezierPath+curved.h"


@implementation MPGraphView


+ (Class)layerClass{
    return [CAShapeLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        self.axisColor = [UIColor blackColor];
        self.isDrawAxis = YES;
        self.isFirstBlank = YES;
        self.isLastBlank = YES;
        self.axisLineWidth = 1.0;
        self.curveGranularity = 1.0;
    }
    return self;
}

//绘图主方法
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
        //画折线
        ((CAShapeLayer *)self.layer).fillColor=[UIColor clearColor].CGColor;
        
        if ([self.delegate respondsToSelector:@selector(numbersOfLines)]&&[self.delegate respondsToSelector:@selector(valuesForLineIndex:)]) {
            
            [self graphPathFromPoints];
            if (self.isDrawAxis) {
                //画坐标
                [self drawAxis];
            }
        
        }

        //((CAShapeLayer *)self.layer).path = path1.CGPath;
    
}
//画坐标轴
- (UIBezierPath *)drawAxis{
    //1.获取y轴刻度数量
    int yCount = 10;//default 10
    if ([self.delegate respondsToSelector:@selector(numbersOfYScales:)]) {
        yCount = [self.delegate numbersOfYScales:self];
    }
    UIBezierPath *path=[UIBezierPath bezierPath];
    path.lineWidth = self.axisLineWidth;
    //画X Y轴
    CGPoint origin = CGPointMake(spaceX,self.height-PADDING);
    CGPoint pointMaxY = CGPointMake(origin.x, PADDING-5);
    CGPoint pointMaxX = CGPointMake(self.width - spaceX, origin.y);
    [path moveToPoint:pointMaxY];
    [path addLineToPoint:origin];
    [path addLineToPoint:pointMaxX];
    [self.axisColor setStroke];
    [path strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
    
    //获取字体属性
    NSDictionary *dicOfX = @{NSFontAttributeName:kDefaultFont};
    if ([self.delegate respondsToSelector:@selector(titleAttributesForAxisX)]) {
        NSDictionary *attributes = [self.delegate titleAttributesForAxisX];
        if (attributes!=nil) {
            dicOfX = attributes;
        }
    }
    NSDictionary *dicOfY = @{NSFontAttributeName:kDefaultFont};
    if ([self.delegate respondsToSelector:@selector(titleAttributesForAxisY)]) {
        NSDictionary *attributes = [self.delegate titleAttributesForAxisY];
        if (attributes!=nil) {
            dicOfY = attributes;
        }
    }
    //画指示线
    for (int i = 0 ; i < xCount ; i++) {
        CGPoint point = [self pointAtIndex:i scaleValue:0];
        CGPoint pointY1 = CGPointMake(point.x, self.height - PADDING);
        CGPoint pointY2 = CGPointMake(point.x, PADDING);
        //是否画Y轴平行线(垂直线)
        if (self.isDrawYParallelLines) {
            UIBezierPath *newPath = [UIBezierPath bezierPath];
            [self.axisColor setStroke];
            [newPath moveToPoint:pointY1];
            [newPath addLineToPoint:pointY2];
            [newPath closePath];
            [newPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
            [path appendPath:newPath];
        }
        //X轴刻度
        if ([self.delegate respondsToSelector:@selector(titleOfXcale:)]) {
            //圆点显示不在X轴上,且当前点x为圆点x
            if (!self.isOriginAtX && point.x == spaceX) {
                continue;
            }
            NSString *titleOfX = [self.delegate titleOfXcale:i];
            if (titleOfX != nil && ![titleOfX isEqualToString:@""]) {
                CGSize size = [titleOfX boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesFontLeading attributes:dicOfX context:nil].size;
                CGPoint p = pointY1;
                p.y += 10.0;
                p.x -= size.width/2.0;
                [titleOfX drawAtPoint:p withAttributes:dicOfX];
            }
        }
    }

    //画X平行线
    float gap = (self.valueRanges.max - self.valueRanges.min)/(yCount-1);
    float gapHeight = (self.height - 2*PADDING)/(yCount-1);//1为多出来空白,美观
    
    //从圆点开始计算
    for (int i = 0 ; i < yCount ; i++) {
        CGPoint pointX1 = CGPointMake(spaceX,self.height-PADDING-(i)*gapHeight);
        CGPoint pointX2 = CGPointMake(pointMaxX.x, pointX1.y);
        if (i == 0) {
            //线条与X轴重合,无需重复画
            if (self.isOriginAtX) {
                continue;
            }
        }else{
            UIBezierPath *path1 = [UIBezierPath bezierPath];
            [self.axisColor setStroke];
            [path1 moveToPoint:pointX1];
            [path1 addLineToPoint:pointX2];
            [path1 closePath];
            [path1 strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
            [path appendPath:path1];
        }
        NSString *str = [NSString stringWithFormat:@"%.f",round(gap*i)];
        CGSize size = [str boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesFontLeading attributes:dicOfY context:nil].size;
        [str drawAtPoint:CGPointMake(pointX1.x-size.width-10.0, pointX1.y-size.height/2.0) withAttributes:dicOfY];

    }
    return path;

}

//画折线与点
- (void)graphPathFromPoints{
    

        //获取有多少条折线
        int lineCount = [self.delegate numbersOfLines];
        for (int i = 0 ;i < lineCount ; i++) {
            //1.获取数据源
            NSArray *values = [self.delegate valuesForLineIndex:i];
            if (i == 0) {
                //计算X间距
                NSInteger count = values.count+1;
                if (self.isFirstBlank) {
                    count ++;
                }
                if(self.isLastBlank){
                    count ++;
                }
                spaceX = (self.frame.size.width)/count;
                xCount = [values count];
            }
            //2.获取线条颜色 默认蓝色
            UIColor *lineColor = kDefaultLineColor;
            if ([self.delegate respondsToSelector:@selector(colorOfLineAtLineIndex:)]) {
                lineColor = [self.delegate colorOfLineAtLineIndex:i];
            }
            //3.获取线条线宽
            float lineWidth = kDefaultLineWidth;
            if ([self.delegate respondsToSelector:@selector(lineWidthForLineIndex:)]) {
                lineWidth = [self.delegate lineWidthForLineIndex:i];
            }
            //4.获取是否填充以及填充的颜色
            BOOL fill = NO;
            NSArray *fillColors = nil;
            if ([self.delegate respondsToSelector:@selector(gradientFillColorsForLineIndex:)]) {
                fillColors = [self.delegate gradientFillColorsForLineIndex:i];
                fill = [fillColors count];
            }
            //5.获取点的大小
            CGSize buttonSize;
            if ([self.delegate respondsToSelector:@selector(sizeOfDotAtLineIndex:)]) {
                buttonSize = [self.delegate sizeOfDotAtLineIndex:i];
            }else{
                buttonSize = CGSizeMake(8, 8);
            }
            //6.获取点的颜色
            UIColor *buttonBackgroundColor;
            if ([self.delegate respondsToSelector:@selector(colorOfDotAtLineIndex:)]) {
                buttonBackgroundColor = [self.delegate colorOfDotAtLineIndex:i];
            }else{
                buttonBackgroundColor = [UIColor whiteColor];
            }
            //7.获取是否显示明细
            BOOL isShowDetail = YES;
            if ([self.delegate respondsToSelector:@selector(isShowDetailAtLineIndex:)]) {
                isShowDetail = [self.delegate isShowDetailAtLineIndex:i];
            }
            //8.获取是否圆滑
            BOOL isCurve = NO;
            if ([self.delegate respondsToSelector:@selector(isCurveAtLineIndex:)]) {
                isCurve = [self.delegate isCurveAtLineIndex:i];
            }
            //转换值到比例点
            NSArray *scaleValues = [self pointsForArray:values];
            NSMutableArray *points = [[NSMutableArray alloc] init];
            UIBezierPath *path=[UIBezierPath bezierPath];

            UIBezierPath *linePath = [UIBezierPath bezierPath];
            for (NSInteger i=0;i<scaleValues.count;i++) {
                
                CGPoint point=[self pointAtIndex:i scaleValue:[scaleValues[i] floatValue]];
                [points addObject:[NSValue valueWithCGPoint:point]];
                if(i==0){
                    [path moveToPoint:point];
                    [linePath moveToPoint:point];
                }else{
                    [path addLineToPoint:point];
                    [linePath addLineToPoint:point];
                }
                MPButton *button=[MPButton buttonWithType:UIButtonTypeCustom tappableAreaOffset:UIOffsetMake(25, 25)];
                [button setBackgroundColor:buttonBackgroundColor];
                button.layer.cornerRadius=buttonSize.height/1.5;
                button.layer.borderWidth=1;
                button.layer.borderColor=[[UIColor clearColor] CGColor];
                button.frame = CGRectMake(0.0, 0.0, buttonSize.width, buttonSize.height);
                button.center=point;
                [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
                //是否显示明细
                if (isShowDetail) {
                    button.userInteractionEnabled = NO;
                    NSString *value = [NSString stringWithFormat:@"%.2f",[values[i] doubleValue]];
                    //明细属性
                    NSDictionary *detailDic = @{NSFontAttributeName:kDefaultFont};
                    if ([self.delegate respondsToSelector:@selector(titleAttributesForDotDetailAtLineIndex:)]) {
                        detailDic = [self.delegate titleAttributesForDotDetailAtLineIndex:i];
                    }
                    
                    CGRect strRect = [value boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesFontLeading attributes:detailDic context:nil];
                    CGPoint p = point;
                    p.x = p.x - strRect.size.width/2.0;
                    p.y = p.y - buttonSize.height/2.0-strRect.size.height;
                    [value drawAtPoint:p withAttributes:detailDic];
                    
                }else{
                    button.userInteractionEnabled = YES;
                }
                
            }
            //曲线圆滑
            if (isCurve) {
                float curveGranularity = 20.0;
                if ([self.delegate respondsToSelector:@selector(curveGranularityForLineIndex:)]) {
                    curveGranularity = [self.delegate curveGranularityForLineIndex:i];
                }
                path=[path smoothedPathWithGranularity:curveGranularity];
                linePath = [linePath smoothedPathWithGranularity:curveGranularity];
            }
            //填充
            if(fill){
                CGPoint last = [[points lastObject] CGPointValue];
                CGPoint first = [[points firstObject] CGPointValue];
                //底部也画上线
                [path addLineToPoint:CGPointMake(last.x,self.height-PADDING)];
                [path addLineToPoint:CGPointMake(first.x,self.height-PADDING)];
                [path addLineToPoint:first];
                
                NSMutableArray *cgFillColors = [[NSMutableArray alloc] init];
                for (UIColor *color in fillColors) {
                    [cgFillColors addObject:(id)[color CGColor]];
                }
                CAGradientLayer *gradient = [CAGradientLayer layer];
                gradient.frame = self.bounds;
                gradient.colors = cgFillColors;
                //渐变填充
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame = self.bounds;
                //设置填充的路径
                maskLayer.path = path.CGPath;
                gradient.mask=maskLayer;
                [self.layer addSublayer:gradient];
                
                //线宽
                [[UIColor clearColor] setStroke];
                [path closePath];
                [path strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
                
            }
            [lineColor setStroke];
            linePath.lineWidth = lineWidth;
            [linePath strokeWithBlendMode:kCGBlendModeOverlay alpha:0.9];

        }
}

//计算点得位置
- (CGPoint)pointAtIndex:(NSInteger)index scaleValue:(float)scaleValue{
    if (self.isFirstBlank) {
        return CGPointMake(2*spaceX+(spaceX)*index,self.height-((self.height-PADDING*2)*scaleValue+PADDING));
    }else{
        return CGPointMake(spaceX+(spaceX)*index,self.height-((self.height-PADDING*2)*scaleValue+PADDING));
    }
}


/*
- (void)animate{
    
    if(self.detailView.superview)
        [self.detailView removeFromSuperview];

    
    
    gradient.hidden=YES;
    
    //画坐标
    ((CAShapeLayer *)self.layer).strokeColor = [[UIColor colorWithWhite:0 alpha:1.0] CGColor];
    UIBezierPath *path=[self drawAxis];
    ((CAShapeLayer *)self.layer).fillColor=[UIColor clearColor].CGColor;
    ((CAShapeLayer *)self.layer).strokeColor = ((UIColor *)self.lineColors[0]).CGColor;
    ((CAShapeLayer *)self.layer).path = [self graphPathFromPoints].CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = self.animationDuration;
    animation.delegate=self;
    [self.layer addAnimation:animation forKey:@"MPStroke"];

    

    for (UIButton* button in buttons) {
        [button removeFromSuperview];
    }
    

    
    buttons=[[NSMutableArray alloc] init];
    
    CGFloat delay=((CGFloat)self.animationDuration)/(CGFloat)points.count;
    

    
    for (NSInteger i=0;i<points.count;i++) {
        
        
        CGPoint point=[self pointAtIndex:i];
        
        MPButton *button=[MPButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:self.lineColors[0]];
        button.layer.cornerRadius=3;
        button.frame=CGRectMake(0, 0, 6, 6);
        button.center=point;
        [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i;
        button.transform=CGAffineTransformMakeScale(0,0);
        [self addSubview:button];
        
        [self performSelector:@selector(displayPoint:) withObject:button afterDelay:delay*i];
        [buttons addObject:button];
    }
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{

    self.waitToUpdate=NO;
    gradient.hidden=0;

}


- (void)displayPoint:(UIButton *)button{
    
        [UIView animateWithDuration:.2 animations:^{
            button.transform=CGAffineTransformMakeScale(1, 1);
        }];
    
    
}

*/


@end
