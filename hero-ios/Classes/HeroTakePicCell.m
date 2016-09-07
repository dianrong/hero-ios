//
//  HeroTakePicCell.m
//  hero
//
//  Created by 朱成尧 on 5/4/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import "HeroTakePicCell.h"
#import "HeroPhotoImage.h"

@interface HeroTakePicCell ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *label;

@end

@implementation HeroTakePicCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:CGRectMake(0, 0, 2, 2)])) return nil;
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(.55, .45, .8, .8)];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.backgroundColor = [UIColor whiteColor];
    self.imageView.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:iconBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    [self addSubview:self.imageView];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 1.45, 2, .25)];
    self.label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.label.font = [UIFont systemFontOfSize:12];
    self.label.textColor = [UIColor colorWithWhite:.3 alpha:1];
    self.label.text = @"相机拍摄";
    self.label.adjustsFontSizeToFitWidth = YES;
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
    return self;
}

@end
