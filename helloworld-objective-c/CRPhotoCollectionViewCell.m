//
//  CRPhotoCollectionViewCell.m
//  helloworld-objective-c
//
//  Created by CHENHSIN-PANG on 2015/5/29.
//  Copyright (c) 2015年 CinnamonRoll. All rights reserved.
//

#import "CRPhotoCollectionViewCell.h"

@implementation CRPhotoCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        self.clipsToBounds = YES;
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];

    [self.imageView sizeToFit];
    
    
    CGFloat ratio = (self.imageView.image.size.height/self.imageView.image.size.width);
    
    self.imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), ratio*CGRectGetWidth(self.frame));
    
    self.imageView.center = CGPointMake(0.5*CGRectGetWidth(self.frame), 0.5*CGRectGetHeight(self.frame));
}

@end
