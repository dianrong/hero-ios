//
//  HeroViewController.m
//  hero-ios
//
//  Created by 刘国平 on 09/07/2016.
//  Copyright (c) 2016 刘国平. All rights reserved.
//

#import "HeroViewController.h"
#import "UIView+paper.h"
@interface HeroViewController1 ()

@end

@implementation HeroViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor grayColor];
    view.layer.cornerRadius = 50;
    [self.view addSubview:view];
    view.rippleExpanding = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
