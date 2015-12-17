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
#import "GCTabBar.h"

@interface GCTabBarController ()

@property (nonatomic, strong) GCTabBar *mTabBar;

@end

@implementation GCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!_mTabBar) {
        // 清除tabbar的子view
        for (UIView *view in self.tabBar.subviews) {
            [view removeFromSuperview];
        }
        
        GCTabBar *tabBar = [[GCTabBar alloc] initWithFrame:self.tabBar.bounds];
        _mTabBar = tabBar;
        // 将我们的controllers传到自定义的tabbar里
        tabBar.controllers = self.childViewControllers;
        
        __weak typeof(self) ws = self;
        
        tabBar.btnOnClick = ^(NSInteger index){
            ws.selectedIndex = index;
        };
        
        // 添加到我们系统的tabbar里
        [self.tabBar addSubview:tabBar];
    }
}

// 创建子控制器
- (void)createControllers
{
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建主界面
    [self createControllerWithTitle:NSLocalizedString(@"session", @"")
                              image:@"tabbar_mainframe"
                      selectedImage:@"tabbar_mainframeHL"
                              class:[GCSessionController class]];
    // 创建我的界面
    [self createControllerWithTitle:NSLocalizedString(@"profile", @"")
                              image:@"tabbar_me"
                      selectedImage:@"tabbar_meHL"
                              class:[GCProfileController class]];
    // 创建发现界面
    [self createControllerWithTitle:NSLocalizedString(@"discover", @"")
                              image:@"tabbar_discover"
                      selectedImage:@"tabbar_discoverHL"
                              class:[GCDiscoverController class]];
}

- (void)createControllerWithTitle:(NSString *)title
                            image:(NSString *)image
                    selectedImage:(NSString *)selectedImage
                            class:(Class)class
{
    UIViewController *vc = [[class alloc] init];
    vc.title = title;
    
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
