//
//  WsdCollectionViewCell.m
//  PhotoTest
//
//  Created by sunlight on 14-7-1.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdCollectionViewCell.h"

@implementation WsdCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.tag = 1401;
        [self addSubview:imageView];
        UIImageView *selectedImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        selectedImageView.tag = 1402;
        selectedImageView.image = [UIImage imageNamed:@"overlay2"];
        [self addSubview:selectedImageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
