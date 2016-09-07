//
//  MEBarButtonItem.m
//  on2me
//
//  Created by atman on 15/2/4.
//  Copyright (c) 2015年 GPLIU. All rights reserved.
//

#import "HeroBarButtonItem.h"
#import "UILazyImageView.h"
#import "UIImage+alpha.h"

@implementation HeroBarButtonItem
-(instancetype)initWithJson:(NSDictionary*)json{
    NSString *imageName = json[@"image"];
    NSString *title = json[@"title"];
    NSString *tintColor = json[@"tintColor"];
    if (tintColor) {
        self.tintColor = UIColorFromStr(@"tintColor");
    }

    if (imageName) {
        if ([imageName hasPrefix:@"http"]) {
            NSData *d = [UILazyImageView getCachedImageDataForURL:[NSURL URLWithString:imageName]];
            if (d) {
                self = [super initWithImage:[UIImage imageWithData:d] style:UIBarButtonItemStylePlain target:self action:@selector(onAction:)];
            }else{
                self = [super initWithImage:[UIImage imageWithColor:[UIColor whiteColor]] style:UIBarButtonItemStylePlain target:self action:@selector(onAction:)];
                [UILazyImageView registerForName:imageName block:^(NSData *data) {
                    self.image = [UIImage imageWithData:data];
                }];
            }
        }else{
            self = [super initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:self action:@selector(onAction:)];
        }
        
    }else if (title){
        self = [super initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(onAction:)];
    }else{
        self = [super init];
    }
    if (self) {
        self.json = json;
    }
    return self;
}
-(void)onAction:(id)sender
{
    [self.controller.view endEditing:YES];
    if (self.json[@"click"]) {
        [self.controller on:self.json[@"click"]];
    }
}

@end
