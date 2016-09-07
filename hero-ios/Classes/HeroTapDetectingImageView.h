//
//  HeroTapDetectingImageView.h
//  hero
//
//  Created by 朱成尧 on 5/5/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeroTapDetectingImageViewDelegate <NSObject>

@optional

- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView tripleTapDetected:(UITouch *)touch;

@end

@interface HeroTapDetectingImageView : UIImageView

@property (nonatomic, weak) id <HeroTapDetectingImageViewDelegate> tapDelegate;

@end
