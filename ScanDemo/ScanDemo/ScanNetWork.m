//
//  ScanNetWork.m
//  ScanDemo
//
//  Created by sunlight on 14-9-17.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "ScanNetWork.h"

@implementation ScanNetWork

+(id)shareInstance{
    static ScanNetWork *network;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[self alloc] init];
    });
    return network;
}

@end
