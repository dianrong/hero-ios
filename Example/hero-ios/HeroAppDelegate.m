//
//  HeroAppDelegate.m
//  hero-ios
//
//  Created by 刘国平 on 09/07/2016.
//  Copyright (c) 2016 刘国平. All rights reserved.
//

#import "HeroAppDelegate.h"
#import "HeroApp.h"
#import "UIView+hero.h"


@interface HeroAppDelegate ()
@property (nonatomic,strong) HeroApp *app;

@end


@implementation HeroAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.app = [[HeroApp alloc]init];
    self.app.window = self.window;
    NSString *urlHost = @"http://localhost:3000";
    NSString *home = @"__PATH";
    NSString *urlPath = [NSString stringWithFormat:@"%@%@",urlHost,[home hasPrefix:@"__"]?@"":home];
    [self.app on:@{
                   @"tabs":
                       @[@{
                             @"url":[NSString stringWithFormat:@"%@%@",urlPath,@"/home.html"],
                             @"class":@"ViewController",
                             }
                         ]
                   }];
    return YES;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
