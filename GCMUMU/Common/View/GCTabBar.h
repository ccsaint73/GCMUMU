//
//  GCTabBar.h
//  GCMUMU
//
//  Created by 郭存 on 15/12/10.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCTabBar : UIView

@property (nonatomic, strong) NSArray *controllers;

@property (nonatomic, copy) void(^btnOnClick)(NSInteger index);

- (void)setBtnWithTag:(NSInteger)tag;

@end
