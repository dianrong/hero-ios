//
//  MEWebView.m
//  on2me
//
//  Created by atman on 15/1/7.
//  Copyright (c) 2015年 GPLIU. All rights reserved.
//

#import "HeroSwitch.h"

@implementation HeroSwitch
{
}
-(void)on:(NSDictionary *)json
{
    [super on:json];
    [self addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventValueChanged];
    if (json[@"value"]) {
        self.on =  ((NSNumber*)json[@"value"]).boolValue ;
    }
}
-(void)onClicked:(UISwitch*)sw
{
    if (self.json[@"click"]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.json[@"click"]];
        [dic setObject:@(self.on) forKey:@"value"];
        [self.controller on:dic];
    }
}

@end
