//
//  YDView.h
//  YDReader
//
//  Created by sunlight on 14-10-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDView : UIView

@property (strong,nonatomic) CAGradientLayer *gradientLayer;

-(instancetype)initWithFrame:(CGRect)frame gradientLayer:(CAGradientLayer *)gradientLayer;

@end
