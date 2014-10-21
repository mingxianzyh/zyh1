//
//  main.m
//  NSMutableStringTest
//
//  Created by sunlight on 14-2-28.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    NSMutableString *str = [NSMutableString stringWithString:@"123"];
    
    [str appendString:@"4"];
    [str appendFormat:@"%i",1];
    NSLog(@"%@",str);
    
    return 0;
}

