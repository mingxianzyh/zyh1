//
//  MyAnnotation.h
//  MapKitDemo
//
//  Created by sunlight on 14-3-26.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyAnnotation : NSObject<MKAnnotation>

// Center latitude and longitude of the annotion view.
// The implementation of this property must be KVO compliant.
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;


// Title and subtitle for use by selection UI.
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;

//用来标识在数组中的顺序
@property (nonatomic,assign) NSInteger index;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
