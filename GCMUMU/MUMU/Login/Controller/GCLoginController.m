//
//  GCLoginController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/17.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCLoginController.h"
#import "Easemob.h"
#import "AppDelegate.h"
#import "GCTabBarController.h"
#import "ORProgressHUD.h"

@interface GCLoginController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@end

@implementation GCLoginController

// 登录
- (IBAction)login:(id)sender {
    // 隐藏键盘
    [self.view endEditing:YES];
    // 加载进度条
    [ORProgressHUD show];
    // 调用登录接口
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:_nameField.text password:_pwdField.text completion:^(NSDictionary *loginInfo, EMError *error) {
        // 隐藏进度条
        [ORProgressHUD hide];
        
        if (!error && loginInfo) {
            GCTabBarController *tabBarVC = [[GCTabBarController alloc] init];
            ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = tabBarVC;
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.description delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } onQueue:nil];
}

// 注册
- (IBAction)mmRegister:(id)sender {
    [self.view endEditing:YES];
    [ORProgressHUD show];
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:_nameField.text password:_pwdField.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        [ORProgressHUD hide];
        if (!error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.description delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } onQueue:nil];
}

@end
