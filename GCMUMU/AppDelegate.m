//
//  AppDelegate.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/9.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "AppDelegate.h"
#import "GCTabBarController.h"
#import "GCLoginController.h"
#import "GCSlidingMenuController.h"
#import "Easemob.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 注册环信
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"ori#mumu" apnsCertName:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    // 注册极光推送
    
    // 注册高德地图
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 2.创建登录控制器
    GCLoginController *login = [[GCLoginController alloc] initWithNibName:@"GCLoginController" bundle:nil];
    
    // 3.设置window的跟控制器
    self.window.rootViewController = login;
    
    // 4.设置主窗口并显示
    [self.window makeKeyAndVisible];
    
    return YES;
}

// App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

// App将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

// 申请处理时间
- (void)applicationWillTerminate:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}
@end
