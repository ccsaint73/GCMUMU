//
//  GCTabBar.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/10.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCTabBar.h"
#import "GCTabBarButton.h"

@implementation GCTabBar

- (void)setControllers:(NSArray *)controllers
{
    _controllers = controllers;
    
    [self createInit];
}

- (void)createInit
{
    // 添加button
    // 拿到controller的个数
    NSInteger count = _controllers.count;
    // 计算btn的宽度
    CGFloat btnW = self.frame.size.width / count;
    //
    for (int i = 0; i < count; i ++) {
        // 拿到标签页
        UINavigationController *nav = _controllers[i];
        
        GCTabBarButton *btn = [[GCTabBarButton alloc] initWithFrame:CGRectMake(btnW * i, 0, btnW, 49)];
        // 用标签的title赋值给btn
        [btn setTitle:nav.tabBarItem.title forState:UIControlStateNormal];
        // 设置选中btn的文字颜色
        [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        // 修改文字字体大小
        //        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        // 拿到image
        [btn setImage:nav.tabBarItem.image forState:UIControlStateNormal];
        // [btn setBackgroundImage:nav.tabBarItem.image forState:UIControlStateHighlighted];
        // 拿到selectedImage
        [btn setImage:nav.tabBarItem.selectedImage forState:UIControlStateSelected];
        // 给btn添加响应事件
        [btn addTarget:self action:@selector(btnDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        // 去除高亮
        [btn setAdjustsImageWhenHighlighted:NO];
        // 添加tag值
        btn.tag = 1000 + i;
        
        if (i == 0) {
            btn.selected = YES;
        }
        
        [self addSubview:btn];
    }
}

- (void)btnDidSelected:(UIButton *)sender
{
    // 遍历tabbar的子控件
    for (UIView *view in self.subviews) {
        // 判断是不是uibutton
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            if (btn.tag == sender.tag) {
                btn.selected = YES;
            }else {
                btn.selected = NO;
            }
        }
    }
    
    if (_btnOnClick) {
        _btnOnClick(sender.tag - 1000);
    }
}

@end
