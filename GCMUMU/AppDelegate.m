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
#import "UMSocialSinaHandler.h"
#import "UMSocial.h"
#import "GCGuideController.h"

@interface AppDelegate () <IChatManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 注册环信
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"ori#mumu" apnsCertName:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    // 设置环信代理
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    // 注册极光推送
    
    // 注册高德地图
    
    // 注册友盟
    [UMSocialData setAppKey:UMAppKey];
    // 开始新浪sso授权
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    BOOL notFirst = [[NSUserDefaults standardUserDefaults] boolForKey:@"notFirst"];
    
    if (notFirst) {
        // 创建登录控制器
        GCLoginController *login = [[GCLoginController alloc] initWithNibName:@"GCLoginController" bundle:nil];
        
        // 设置window的跟控制器
        self.window.rootViewController = login;
    }else {
        // 创建导航视图
        GCGuideController *guide = [[GCGuideController alloc] init];
        
        self.window.rootViewController = guide;
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notFirst"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    // 设置主窗口并显示
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

- (void)didReceiveBuddyRequest:(NSString *)username message:(NSString *)message
{
    NSDictionary *dict = @{@"username":username, @"message":message};
    
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"buddy"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
