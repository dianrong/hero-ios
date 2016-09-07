//
//  HeroTableViewCell.h
//  hero
//
//  Created by Liu Guoping on 15/9/5.
//  Copyright (c) 2015年 Liu Guoping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Hero.h"
#import "common.h"

@interface HeroTableViewCell : UITableViewCell
@property (nonatomic,strong) UIView *heroContentView;
-(instancetype)initWithJson:(NSDictionary*)json;
@end
