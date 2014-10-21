//
//  main.m
//  NSArrayTest
//
//  Created by sunlight on 14-2-28.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    NSLog(@"%@",@"array==============================");
    NSArray *array = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    //1
    for (int i = 0; i < [array count]; i++) {
        
        NSLog(@"%@",[array objectAtIndexedSubscript:i]);
        NSLog(@"%@",[array objectAtIndex:i]);
    }
    //2
    NSEnumerator *arrayEnu = [array objectEnumerator];
    for (NSString *str in arrayEnu) {
        NSLog(@"%@",str);
    }
    
    
    NSLog(@"%@",@"set==============================");
    NSSet *set = [NSSet setWithObjects:@"1",@"2",@"3", nil];
    
    for (id s in set) {
        NSLog(@"%@",s);
    }
    
    NSEnumerator *e = [set objectEnumerator];
    
    for (id s in e) {
        NSLog(@"%@",s);
    }
    
    id d ;
    while (d = [e nextObject]) {
        NSLog(@"%@",d);
    }
    NSLog(@"%@",@"dictoryary=======================");
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"one",@"1",@"two",@"3",@"three", nil];
    //获取所有的key进行遍历
    NSArray *keys = [dic allKeys];
    
    for (int i = 0; i < [keys count]; i++) {
        NSLog(@"%@",[dic objectForKey:[keys objectAtIndex:i]]);
    }
    NSLog(@"%@",@"Test NSDictionary");
    
    NSLog(@"%@",[dic allKeysForObject:@"1"]);
    
    
    return 0;
}

