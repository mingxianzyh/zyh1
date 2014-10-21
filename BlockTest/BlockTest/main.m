//
//  main.m
//  BlockTest
//
//  Created by sunlight on 14-3-22.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        __block int i = 10;
        int(^MyBlock)(int) = ^(int a){
            
            NSLog(@"");
            i = 20;
            return a*a;
        };
        i = 40;
        int result = MyBlock(2);
        NSLog(@"%d",i);
        
    }
    return 0;
}

