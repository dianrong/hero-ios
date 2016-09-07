//
//  HeroBadgeLabel.m
//  hero
//
//  Created by 朱成尧 on 4/26/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import "HeroBadgeLabel.h"
#import "hero.h"
#import "UIView+Frame.h"

@interface HeroBadgeLabel ()

@property (nonatomic, strong) UIView *backGroudView;
@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation HeroBadgeLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupViews];
        self.hidden = YES;
    }
    return self;
}

- (void)setupViews {
    _backGroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _backGroudView.backgroundColor = UIColorFromRGB(0xff5323);
    _backGroudView.layer.cornerRadius = 10;
    [self addSubview:_backGroudView];

    _badgeLabel = [[UILabel alloc] initWithFrame:_backGroudView.frame];
    _badgeLabel.backgroundColor = [UIColor clearColor];
    _badgeLabel.textColor = [UIColor whiteColor];
    _badgeLabel.font = [UIFont systemFontOfSize:16.0f];
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_badgeLabel];

    _badgeLabel.userInteractionEnabled = YES;
    _backGroudView.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
}

- (void)setTitle:(NSString *)title {
    self.badgeLabel.text = title;
    if (title.integerValue > 0) {
        [self show];
    } else {
        [self hide];
    }
}

- (void)show {
    self.hidden = NO;
}

- (void)hide {
    self.hidden = YES;
}

@end
