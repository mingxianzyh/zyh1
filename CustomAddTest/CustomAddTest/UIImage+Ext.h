//
//  UIImage+Ext.h
//  CustomAddTest
//
//  Created by sunlight on 14-5-16.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ext)
//压缩图片到指定的尺寸
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
