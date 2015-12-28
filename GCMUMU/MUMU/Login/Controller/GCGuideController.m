//
//  GCGuideController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/25.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCGuideController.h"
#import "AppDelegate.h"
#import "GCLoginController.h"

@interface GCGuideController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation GCGuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

// 设置UI
- (void)setupUI
{
    NSArray *array = @[@"mm", @"mm", @"mm"];
    
    // 添加图片
    for (int i = 0; i < array.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW * i, 0, SCREENW, SCREENH)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:array[i]];
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        
        if (i == (array.count - 1)) {
            // 添加进入应用按钮
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((SCREENW - 80) * 0.5, SCREENH * 0.7, 80, 30)];
            [button setBackgroundImage:[UIImage imageNamed:@"HR_login_btn"] forState:UIControlStateNormal];
            [button setTitle:@"进入应用" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(gotoMainVC:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
    }
    
    // 设置scrollview的属性
    self.scrollView.contentSize = CGSizeMake(array.count * SCREENW, 0);
    self.scrollView.pagingEnabled = YES;
}

- (void)gotoMainVC:(UIButton *)sender
{
    // 先创建 减少转场延迟
    GCLoginController *login = [[GCLoginController alloc] init];
    
    // 添加动画
    [UIView animateWithDuration:1 animations:^{
        self.scrollView.alpha = 0.5;
    } completion:^(BOOL finished) {
        // 切换登陆界面
        ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = login;
    }];
    
}

#pragma mark -- 懒加载 --
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

@end
