//
//  MEBarButtonItem.h
//  on2me
//
//  Created by atman on 15/2/4.
//  Copyright (c) 2015年 GPLIU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "HeroViewController.h"
@interface HeroBarButtonItem : UIBarButtonItem
@property (nonatomic, assign) HeroViewController        *controller;
@property (nonatomic, strong) NSDictionary              *json;

-(instancetype)initWithJson:(NSDictionary*)json;
@end
