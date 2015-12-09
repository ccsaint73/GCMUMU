//
//  GCTabBarController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/9.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCTabBarController.h"
#import "GCDiscoverController.h"
#import "GCSessionController.h"
#import "GCProfileController.h"
#import "GCNavigationController.h"

@interface GCTabBarController ()

@end

@implementation GCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createControllers];
}

- (void)createControllers
{
    // 创建主界面
    [self createControllerWithTitle:NSLocalizedString(@"session", @"")
                              image:@""
                      selectedImage:@""
                              class:[GCSessionController class]];
    
    // 创建发现界面
    [self createControllerWithTitle:NSLocalizedString(@"discover", @"")
                              image:@""
                      selectedImage:@""
                              class:[GCDiscoverController class]];
    
    // 创建我的界面
    [self createControllerWithTitle:NSLocalizedString(@"profile", @"")
                              image:@""
                      selectedImage:@""
                              class:[GCProfileController class]];
}

- (void)createControllerWithTitle:(NSString *)title
                            image:(NSString *)image
                    selectedImage:(NSString *)selectedImage
                            class:(Class)class
{
    UIViewController *vc = [[class alloc] init];
    
    GCNavigationController *nav = [[GCNavigationController alloc] initWithRootViewController:vc];
    
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    [self addChildViewController:nav];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
