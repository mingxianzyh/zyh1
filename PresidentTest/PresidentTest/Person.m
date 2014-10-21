//
//  Person.m
//  PresidentTest
//
//  Created by sunlight on 14-4-22.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "Person.h"

@implementation Person



- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super init]){
        _name = [aDecoder decodeObjectForKey:@"name"];
        _age = [aDecoder decodeIntForKey:@"age"];
    
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInteger:_age forKey:@"age"];
}

-(id)copyWithZone:(NSZone *)zone{

    Person *person = [[self class] allocWithZone:zone];
    person.name = [self.name copyWithZone:zone];
    person.age = self.age;
    return person;
}

@end
