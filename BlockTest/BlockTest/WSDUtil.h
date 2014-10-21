//
//  WSDUtil.h
//  BlockTest
//
//  Created by sunlight on 14-3-22.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef int (^DoubleBlock)(int);
@interface WSDUtil : NSObject

- (void)blockTest1:(int (^)(int))block;
- (void)blockTest2:(DoubleBlock)block;
@end
