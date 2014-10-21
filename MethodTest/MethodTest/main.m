//
//  main.m
//  MethodTest
//
//  Created by sunlight on 14-3-3.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MethodTest.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSArray *array = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:10],[NSNumber numberWithInt:20], nil];
        
        NSPredicate *pre =  [NSPredicate predicateWithFormat:@"self >= 5"];
        
        NSLog(@"%@",[array filteredArrayUsingPredicate:pre]);
        
    }
    return 0;
}

