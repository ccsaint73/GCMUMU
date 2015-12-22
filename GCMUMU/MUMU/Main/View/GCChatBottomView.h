//
//  GCChatBottomView.h
//  GCMUMU
//
//  Created by 郭存 on 15/12/22.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCChatBottomView : UIView

@property (nonatomic, copy) void(^messageDidSend)(NSString *message);

- (void)resetMessageField;

@end
