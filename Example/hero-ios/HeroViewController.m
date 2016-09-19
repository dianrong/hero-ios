//
//  HeroViewController.m
//  hero-ios
//
//  Created by 刘国平 on 09/07/2016.
//  Copyright (c) 2016 刘国平. All rights reserved.
//

#import "HeroViewController.h"
#import "UIView+paper.h"
#import "HeroTextField.h"
@interface HeroViewController1 ()

@end

@implementation HeroViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    HeroTextField *view = [[HeroTextField alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    [self.view addSubview:view];
    view.rippleExpanding = YES;
    [view performSelector:@selector(on:) withObject: @{@"dashBorder":@{@"color":@"ff0000",@"pattern":@[@2,@4]}}];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
