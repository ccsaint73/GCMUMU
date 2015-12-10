//
//  GCSlidingMenuController.h
//  GCSlidingMenu
//
//  Created by 郭存 on 15/12/9.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCSlidingMenuController : UIViewController

@property (nonatomic, strong) UIViewController *leftVC;
@property (nonatomic, strong) UIViewController *rightVC;
@property (nonatomic, strong) UIViewController *mainVC;

+ (instancetype)sharedSlider;
+ (void)hide;
+ (void)showLeftViewController;
+ (void)showRightViewController;
+ (void)showContentViewController:(Class)class;

@end
