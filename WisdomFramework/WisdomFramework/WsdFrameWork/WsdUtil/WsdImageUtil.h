//
//  WsdImageUtil.h
//  WisdomFramework
//
//  Created by sunlight on 14-7-16.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WsdImageUtil : NSObject

//根据颜色和大小生成图片
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

//image 调整方向
+ (UIImage *)fixOrientation:(UIImage *)aImage;

@end
