//
//  MethodTest.m
//  MethodTest
//
//  Created by sunlight on 14-3-3.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "MethodTest.h"

@implementation MethodTest

- (void) test{

    NSLog(@"%@",@"test");
    [self hide ];
}

- (void) hide{
    NSLog(@"%@",@"hidden");
}

@end
