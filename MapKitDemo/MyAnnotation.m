//
//  MyAnnotation.m
//  MapKitDemo
//
//  Created by sunlight on 14-3-26.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation


// Called as a result of dragging an annotation view.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    _coordinate = newCoordinate;
}

@end
