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
#import "APService.h"

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
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    // Required
    [APService setupWithOption:launchOptions];
    // 注册高德地图
    
    // 注册友盟
    [UMSocialData setAppKey:UMAppKey];
    
    // 开始新浪sso授权
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    
    // 主窗口处理逻辑
    [self setupMain];
    
    return YES;
}

- (void)setupMain
{
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    BOOL notFirst = [[NSUserDefaults standardUserDefaults] boolForKey:@"notFirst"];
    // BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"notFirst"];
    
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
}

// 苹果服务器给我们返回devicetoken的代理方法
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    // 将devicetoken传给极光服务器
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    // 当应用在后台的时候，点击推送的通知调用该方法
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
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
