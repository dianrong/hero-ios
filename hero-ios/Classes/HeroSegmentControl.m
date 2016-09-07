//
//  MESegmentControl.m
//  on2me
//
//  Created by atman on 14/12/18.
//  Copyright (c) 2014年 GPLIU. All rights reserved.
//

#import "HeroSegmentControl.h"
#import "UILazyImageView.h"
@implementation HeroSegmentControl
{
    NSArray *_data;
    NSMutableArray *_actions;
    CGRect frame;
}
-(void)on:(NSDictionary *)json
{
    [super on:json];
    frame = self.frame;
    self.momentary = NO;
    [self addTarget:self action:@selector(onChange:) forControlEvents:UIControlEventValueChanged];
    if (json[@"dataSource"]) {
        _data = json[@"dataSource"];
        for (int i = 0; i < _data.count; i++) {
            NSDictionary *item = _data[i];
            if (item[@"image"]) {
                [UILazyImageView registerForName:item[@"image"] block:^(NSData *data) {
                    [self insertSegmentWithImage:[UIImage imageWithData:data scale :[UIScreen mainScreen].scale] atIndex:self.numberOfSegments animated:YES];
                }];
            }
            if (item[@"title"]) {
                [self insertSegmentWithTitle:item[@"title"] atIndex:self.numberOfSegments animated:YES];
            }
            
        }
    }
    if (json[@"selectedSegmentIndex"]) {
        self.selectedSegmentIndex = ((NSNumber*)json[@"selectedSegmentIndex"]).integerValue;
        [self sendData:self.selectedSegmentIndex];
    }
    if (json[@"action"]) {
        _actions = [NSMutableArray arrayWithArray:json[@"action"]];
        [self sendData:self.selectedSegmentIndex];
    }

}
-(void)onChange:(UISegmentedControl*)sender
{
    [self sendData:self.selectedSegmentIndex];
}
-(void)sendData:(NSInteger)index{
    if (_actions) {
        if (_actions.count > self.selectedSegmentIndex) {
            [self.controller on:_actions[index]];
        }
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.frame = frame;
    if (self.superview) {
        self.center = CGPointMake(self.superview.bounds.size.width/2, self.superview.bounds.size.height/2);
    }
}
-(void)didMoveToSuperview{
    [super didMoveToSuperview];
}
@end
