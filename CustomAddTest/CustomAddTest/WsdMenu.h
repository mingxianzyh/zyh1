//
//  WsdMenu.h
//  CustomAddTest
//
//  Created by sunlight on 14-5-14.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WsdMenu : NSObject

//标题
@property (nonatomic,copy) NSString *title;

//图片名称
@property (nonatomic,copy) NSString *imageName;

//当前标记号
@property (nonatomic,assign) NSInteger *indexNo;

//视图控制器类名
@property (nonatomic,copy) NSString *viewControllerClassName;

@end
