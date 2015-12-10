//
//  GCTabBarButton.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/10.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCTabBarButton.h"

#define RATIO 0.3

@implementation GCTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    }
    return self;
}

// 返回文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.frame.size.height * (1 - RATIO), self.frame.size.width, self.frame.size.height * RATIO);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake((self.frame.size.width - self.frame.size.height * 0.5) * 0.5, self.frame.size.height * 0.1, self.frame.size.height * 0.5, self.frame.size.height * 0.5);
}

@end
