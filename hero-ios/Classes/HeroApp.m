//
//  HEROViewController.m
//  hero
//
//  Created by Liu Guoping on 15/8/19.
//  Copyright (c) 2015年 Liu Guoping. All rights reserved.
//





#import "HeroApp.h"
#import "UIView+Hero.h"

@interface HeroApp()<UITabBarControllerDelegate>
@end
@implementation HeroApp
{

}
-(void)on:(NSDictionary *)json{
    if (json[@"tabs"]) {
        NSArray *arr = json[@"tabs"];
        UITabBarController *tabCon = [[UITabBarController alloc]init];
        tabCon.tabBar.translucent = false;
        tabCon.automaticallyAdjustsScrollViewInsets = NO;
        tabCon.delegate = self;
        for (int i =0;i<arr.count;i++) {
            NSDictionary *dic = arr[i];
            NSString *type = dic[@"class"];
            HeroViewController *vc = [[NSClassFromString(type) alloc]initWithUrl:dic[@"url"]];
            vc.title = dic[@"title"];
            UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:dic[@"title"] image:[UIImage imageNamed: dic[@"image"]] tag:i];
            [vc setTabBarItem:item];
            [tabCon addChildViewController:vc];
            if (i == 0) {
                tabCon.title = vc.title;
                tabCon.navigationItem.leftBarButtonItem = vc.navigationItem.leftBarButtonItem;
                tabCon.navigationItem.rightBarButtonItem = vc.navigationItem.rightBarButtonItem;
                tabCon.navigationItem.titleView = vc.navigationItem.titleView;
            }
        }
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tabCon];
        nav.navigationBar.translucent = false;
        [nav setNavigationBarHidden:NO];
        [tabCon.view setTintColor:UIColorFromStr(@"37B98F")];
        [APP setStatusBarStyle:UIStatusBarStyleLightContent];
        if (self.window) {
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }else{
            APP.keyWindow.rootViewController = nav;
            [APP.keyWindow makeKeyAndVisible];
        }
        [[NSNotificationCenter defaultCenter] addObserverForName:@"tabSelect" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            NSInteger selected = [note.object[@"value"] integerValue];
            tabCon.selectedIndex = selected;
            [self tabBarController:tabCon didSelectViewController:tabCon.selectedViewController];
            [nav popToRootViewControllerAnimated:NO];
        }];
    }
}
#pragma mark tabBarController delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    tabBarController.navigationItem.title = viewController.title;
    tabBarController.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem;
    tabBarController.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem;
    tabBarController.navigationItem.titleView = viewController.navigationItem.titleView;
}

@end
