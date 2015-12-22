
//
//  GCChatBottomView.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/22.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCChatBottomView.h"

@interface GCChatBottomView()

@property (weak, nonatomic) IBOutlet UITextField *messageField;

@end

@implementation GCChatBottomView

- (IBAction)sendMesssage:(id)sender {
    if (_messageField.text.length > 0) {
        if (_messageDidSend) {
            _messageDidSend(_messageField.text);
        }
    }
}

- (void)resetMessageField
{
    _messageField.text = @"";
}

@end
