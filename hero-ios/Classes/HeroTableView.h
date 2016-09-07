//
//  METableView.h
//  on2me
//
//  Created by atman on 14/12/18.
//  Copyright (c) 2014年 GPLIU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Hero.h"
@interface HeroTableView:UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) NSArray *dataIndex;

@end
