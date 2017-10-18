//
//  HeroViewController.m
//  hero-ios
//
//  Created by 刘国平 on 09/07/2016.
//  Copyright (c) 2016 刘国平. All rights reserved.
//

#import "ViewController.h"
#import "UIView+paper.h"
#import "HeroTextField.h"
@interface ViewController ()

@end

@implementation ViewController
-(void)loadView{
    [super loadView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    ((UIScrollView*)self.view).contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
@end
