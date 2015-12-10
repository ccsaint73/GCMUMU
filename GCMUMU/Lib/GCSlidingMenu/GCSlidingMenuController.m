//
//  GCSlidingMenuController.m
//  GCSlidingMenu
//
//  Created by 郭存 on 15/12/9.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCSlidingMenuController.h"

#define LEFTW    (self.view.frame.size.width * 0.7)
#define RIGHTW   (self.view.frame.size.width * 0.7)
#define Interval 0.25

@interface GCSlidingMenuController ()
{
    CGFloat _originX;
    UIView  *_contentView;
}
@end

@implementation GCSlidingMenuController

#pragma mark -- 

+ (instancetype)sharedSlider
{
    static GCSlidingMenuController *slider = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        slider = [[self alloc] init];
    });
    
    return slider;
}

+ (void)showLeftViewController
{
    [[self sharedSlider] showLeftViewController];
}

+ (void)showRightViewController
{
    [[self sharedSlider] showRightViewController];
}

+ (void)showContentViewController:(Class)class
{
    [[self sharedSlider] showContentViewController:class];
}

+ (void)hide
{
    [[self sharedSlider] hide];
}

- (void)hide
{
    CGRect frame = _contentView.frame;
    frame.origin.x = 0;
    
    [UIView animateWithDuration:Interval animations:^{
        _contentView.frame = frame;
    }];
}

- (void)showLeftViewController
{
    if (_leftVC) {
        CGRect frame = _leftVC.view.frame;
        frame.origin.x = LEFTW;
        
        [UIView animateWithDuration:Interval animations:^{
            _leftVC.view.frame = frame;
        }];
    }
}

- (void)showRightViewController
{
    if (_rightVC) {
        CGRect frame = _rightVC.view.frame;
        frame.origin.x = -RIGHTW;
    
        [UIView animateWithDuration:Interval animations:^{
            _rightVC.view.frame = frame;
        }];
    }
}

- (void)showContentViewController:(Class)class
{
    
}

#pragma mark --

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupLeftAndRight];
    [self setupInit];
    [self setupGestureRecognizer];
}

- (void)setupInit
{
    // 设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建contentView
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_contentView];
    }
    
    // 设置主控制器
    if (_mainVC) {
        [_contentView addSubview:_mainVC.view];
    }
}

- (void)setupLeftAndRight
{
    // 设置左边的vc
    if (_leftVC) {
        _leftVC.view.frame = CGRectMake(0, 0, LEFTW, self.view.frame.size.height);
        [self.view addSubview:_leftVC.view];
    }
    
    // 设置右边的vc
    if (_rightVC) {
        _rightVC.view.frame = CGRectMake(self.view.frame.size.width - RIGHTW, 0, RIGHTW, self.view.frame.size.height);
        [self.view addSubview:_rightVC.view];
    }
}

- (void)setupGestureRecognizer
{
    // 添加滑动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.view addGestureRecognizer:pan];
    
    // 添加点击手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSlide:)];
//    [self.view addGestureRecognizer:tap];
}

- (void)panView:(UIPanGestureRecognizer *)sender
{
    // 监听起始点
    if (sender.state == UIGestureRecognizerStateBegan) {
        _originX = _contentView.frame.origin.x;
    }
    
    // 设置弹簧效果
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGFloat offsetX = _contentView.frame.origin.x;
        
        if (offsetX >= 0 && offsetX < LEFTW * 0.5) {
            offsetX = 0;
        } else if (offsetX > LEFTW * 0.5 && offsetX <= LEFTW){
            offsetX = LEFTW;
        } else if (offsetX <= 0 && offsetX > -RIGHTW * 0.4){
            offsetX = 0;
        } else if (offsetX > -RIGHTW && offsetX < -RIGHTW * 0.4){
            offsetX = -RIGHTW;
        }
        
        CGRect frame = _contentView.frame;
        frame.origin.x = offsetX;
        
        [UIView animateWithDuration:Interval animations:^{
            _contentView.frame = frame;
        }];
        
        return;
    }
    
    // 监听偏移量
    CGPoint point = [sender translationInView:self.view];
    CGRect frame = self.view.frame;
    frame.origin.x = _originX + point.x;
 
    // 设置界限
    if (frame.origin.x > LEFTW) {
        frame.origin.x = LEFTW;
    }else if (frame.origin.x < -RIGHTW) {
        frame.origin.x = -RIGHTW;
    }
    
    // 判断左滑还是右滑动
    if (frame.origin.x > 0) {
        _rightVC.view.hidden = YES;
        _leftVC.view.hidden = NO;
        
        // 判断左控制器是否存在
        if (!_leftVC) {
            frame.origin.x = 0;
        }
    } else{
        _leftVC.view.hidden = YES;
        _rightVC.view.hidden = NO;
        
        // 判断右控制器是否存在
        if (!_rightVC) {
            frame.origin.x = 0;
        }
    }
    
    // 设置偏移量
    _contentView.frame = frame;
}

- (void)hideSlide:(UITapGestureRecognizer *)tap
{
    [self hide];
}
@end












