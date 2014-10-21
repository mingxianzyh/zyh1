//
//  main.m
//  NumberTest
//
//  Created by sunlight on 14-2-28.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    NSNumber *intNumber = [NSNumber numberWithInt:80];
    NSNumber *floatNumber = [NSNumber numberWithFloat:80.1L];
	
    if([intNumber isEqualToNumber:floatNumber]){
        NSLog(@"%@",@"yes");
    }else{
        NSLog(@"%@",@"false");
    }
    
    return 0;
}

