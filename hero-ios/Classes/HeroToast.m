//
//  HeroToastView.m
//  hero
//
//  Created by zhuyechao on 12/25/15.
//  Copyright © 2015 Liu Guoping. All rights reserved.
//

#import "HeroToast.h"

@implementation HeroToast {
    UIView *shadowView;
    UIImageView *imageView;
    UILabel *label;
    BOOL isShowing;
}

-(void)on:(NSDictionary *)json {
    [super on:json];
    DLog(@"HeroToastView");

    CGRect screenBounds = [UIScreen mainScreen].bounds;
    // 如果shadowView为空则初始化
    if (!shadowView) {
        shadowView = [[UIView alloc] init];
        shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        shadowView.layer.masksToBounds = YES;
        shadowView.layer.cornerRadius = 6;
    }
    // 删除shadowView的subviews
    [shadowView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];

    if (!json[@"icon"] && (!json[@"text"] || [@"" isEqualToString:json[@"text"]])) {
        self.hidden = YES;
        return;
    }

    CGFloat maxWidth = screenBounds.size.width / 2;
    CGFloat top = 0;
    CGFloat spacing = 15;
    CGFloat shadowHeight = 0;
    BOOL show = NO;
    if (json[@"icon"]) {
        show = YES;
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:json[@"icon"]]];
        imageView.frame = CGRectMake(maxWidth / 2 - 16, spacing, 32, 32);
        top += imageView.frame.size.height + imageView.frame.origin.y;
        shadowHeight = imageView.frame.size.height;
        [shadowView addSubview:imageView];
    }
    if (json[@"text"]) {
        show = YES;
        CGFloat topOffset = 8;
        if (0 == top) {
            topOffset = spacing;
        }
        label = [[UILabel alloc] init];
        label.text = json[@"text"];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        CGSize fitSize = [label sizeThatFits:CGSizeMake(maxWidth - 2 * spacing, screenBounds.size.height)];
        [shadowView addSubview:label];
        label.frame = CGRectMake(spacing, top + topOffset, maxWidth - 2 * spacing, fitSize.height);
        if (0 == top) {
            shadowHeight += label.frame.size.height;
        } else {
            shadowHeight += label.frame.size.height + topOffset;
        }
    }
    float time = 2;
    if (json[@"time"]) {
        time = [json[@"time"] floatValue];
    }

    shadowHeight += 2 * spacing;
    shadowView.frame = CGRectMake(0, 0, maxWidth, shadowHeight);
    shadowView.center = KEY_WINDOW.center;

    if (show) {
        // 正在显示不做处理
        if (isShowing)
            return;
        isShowing = YES;
        [KEY_WINDOW addSubview:shadowView];
        self.hidden = NO;
        shadowView.alpha = 0;
        [UIView animateWithDuration:0.45 animations:^{
            shadowView.alpha = 1;
        } completion:nil];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                shadowView.alpha = 0;
            } completion:^(BOOL finished) {
                self.hidden = YES;
                isShowing = NO;
            }];
        });
    } else {
        self.hidden = YES;
    }
}

@end
