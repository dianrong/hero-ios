//
//  MEScrollView.m
//  on2me
//
//  Created by atman on 15/1/5.
//  Copyright (c) 2015年 GPLIU. All rights reserved.
//

#import "HeroScrollView.h"
//#import "UIScrollView+MJRefresh.h"
//#import "MJRefresh.h"
@interface HeroScrollView() <UIScrollViewDelegate>
@end
@implementation HeroScrollView

-(void)on:(NSDictionary *)json
{
    [super on:json];
    self.delegate = self;
    if (json[@"contentSize"]) {
        NSString *x = json[@"contentSize"][@"x"];
        NSString *y = json[@"contentSize"][@"y"];
        CGSize size = CGSizeMake(x.floatValue, y.floatValue);
        if ([x hasSuffix:@"x"]) {
            size.width = SCREEN_W*x.floatValue;
        }
        if ([y hasSuffix:@"x"]) {
            size.width = SCREEN_H*x.floatValue;
        }
        self.contentSize = size;
    }
    if (json[@"contentOffset"]) {
        NSString *x = json[@"contentOffset"][@"x"];
        NSString *y = json[@"contentOffset"][@"y"];
        CGPoint point = CGPointMake(x.floatValue, y.floatValue);
        if ([x hasSuffix:@"x"]) {
            point.x = SCREEN_W*x.floatValue;
        }
        if ([y hasSuffix:@"x"]) {
            point.y = SCREEN_H*x.floatValue;
        }
        self.contentOffset = CGPointMake(x.floatValue, y.floatValue);
    }
//    if (json[@"pullRefresh"]) {
//        if (self.contentSize.height < self.bounds.size.height) {
//            self.contentSize = CGSizeMake(0, self.bounds.size.height+1);
//        }
//        NSDictionary *pull = json[@"pullRefresh"];
//        NSString *idle = pull[@"idle"]?pull[@"idle"]:LS(@"下拉刷新");
//        NSString *pulling = pull[@"pulling"]?pull[@"pulling"]:LS(@"松开立即刷新");
//        NSString *refreshing = pull[@"refreshing"]?pull[@"refreshing"]:LS(@"加载数据中...");
//        
//        __block HeroScrollView *selfBlock = self;
//        [self addLegendHeaderWithRefreshingBlock:^{
//            [selfBlock.controller on:pull[@"action"]];
//        }];
//        self.header.updatedTimeHidden = YES;
//        [self.header setTitle:idle forState:MJRefreshHeaderStateIdle];
//        [self.header setTitle:pulling forState:MJRefreshHeaderStatePulling];
//        [self.header setTitle:refreshing forState:MJRefreshHeaderStateRefreshing];
//        self.header.font = [UIFont boldSystemFontOfSize:13];
//        self.header.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
//
//    }
//    if (json[@"method"]) {
//        NSString *method = json[@"method"];
//        if ([@"stop" isEqualToString:method]) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.header endRefreshing];
//            });
//        }
//    }
}
-(void)addSubview:(UIView *)view{
    [super addSubview:view];
    if (view.frame.size.height+view.frame.origin.y + self.contentInset.top > self.bounds.size.height) {
        self.contentSize = CGSizeMake(0, view.frame.size.height+view.frame.origin.y);
    }
}
-(void)setFixHeaderView:(UIView *)fixHeaderView{
    _fixHeaderView = fixHeaderView;
    _fixHeaderView.frame = CGRectMake(0,-self.contentInset.top, self.bounds.size.width, 64);
    [self addSubview:fixHeaderView];
}
#pragma mark scrollview delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self endEditing:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.fixHeaderView) {
        self.fixHeaderView.frame = CGRectMake(0, scrollView.contentOffset.y, scrollView.bounds.size.width, 64);
        [self bringSubviewToFront:self.fixHeaderView];
    }
}
 -(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView.contentSize.height > scrollView.bounds.size.height && scrollView.contentOffset.y + scrollView.bounds.size.height + 44 > scrollView.contentSize.height) {
        if (self.action[@"bottomNear"]) {
            [self.controller on:self.json[@"bottomNear"]];
        }
    }
}
@end
