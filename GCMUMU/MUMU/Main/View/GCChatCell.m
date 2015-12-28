//
//  GCChatCell.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/25.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCChatCell.h"
#import "EMMessage.h"
#import "EMTextMessageBody.h"

#define Margin  10
#define ICONW   40
#define PADDING 60
#define BTNW    20
#define OFFSET  5
#define IMAGEW  120

@interface GCChatCell()

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UIImageView *contentBg;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UIButton    *contentImage;
@property (nonatomic, strong) UIImageView *imageBg;

@end

@implementation GCChatCell

- (void)setMessage:(EMMessage *)message
{
    _message = message;
    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    if ([username isEqualToString:_message.from]) {
        [self layoutForMe:message];
    }else {
        [self layoutForServer:message];
    }
    
}

- (void)layoutForMe:(EMMessage *)message
{
    // 假数据设置头像
    self.avatar.image = [UIImage imageNamed:@"mm"];
    self.dateLabel.text = @"2015/12/26";
    
    EMTextMessageBody *body = [message.messageBodies lastObject];
    // 计算文字的size
    CGSize replySize = [body.text boundingRectWithSize:CGSizeMake(SCREENW - PADDING * 2 - Margin * 4, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    // 拉伸背景图片
    UIImage *image = [UIImage imageNamed:@"HR_feedback_me"];
    image = [image stretchableImageWithLeftCapWidth:(image.size.width / 2) topCapHeight:image.size.height * 0.8];
    
    self.contentBg.frame = CGRectMake(SCREENW - PADDING - (Margin * 4) - replySize.width, CGRectGetMaxY(self.dateLabel.frame) + Margin, replySize.width + Margin * 4, replySize.height+ Margin * 3);
    self.contentBg.image = image;
    self.contentLabel.frame = CGRectMake( SCREENW - replySize.width - PADDING - Margin * 2, CGRectGetMaxY(self.dateLabel.frame) + Margin * 2.5, replySize.width, replySize.height);
    self.contentLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.text = body.text;
}

- (void)layoutForServer:(EMMessage *)message
{
    // 假数据设置头像
    self.avatar.image = [UIImage imageNamed:@"mm"];
    self.dateLabel.text = @"2015/12/26";
    
    EMTextMessageBody *body = [message.messageBodies lastObject];
    
    // 头像跑到左边来了
    self.avatar.frame = CGRectMake(20, CGRectGetMaxY(self.dateLabel.frame) + Margin, ICONW, ICONW);
    
    // 计算拉伸图片
    CGSize replySize = [body.text boundingRectWithSize:CGSizeMake(SCREENW - PADDING * 2 - Margin * 4, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    
    UIImage *image = [UIImage imageNamed:@"HR_feedback_server"];
    image = [image stretchableImageWithLeftCapWidth:(image.size.width / 2) topCapHeight:image.size.height * 0.75];
    
    self.contentBg.frame = CGRectMake(PADDING + (Margin * 2), CGRectGetMaxY(self.dateLabel.frame) + Margin, replySize.width + Margin * 4, replySize.height+ Margin * 3);
    self.contentBg.image = image;
    self.contentLabel.frame = CGRectMake(PADDING + (Margin * 4), CGRectGetMaxY(self.dateLabel.frame) + Margin * 2, replySize.width, replySize.height);
    self.contentLabel.backgroundColor = [UIColor clearColor];
    
    self.contentLabel.text = body.text;
}

#pragma mark ----------------------
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREENW - 120) / 2, Margin, 120, Margin * 2)];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = [UIColor lightGrayColor];
        _dateLabel.layer.cornerRadius = Margin;
        _dateLabel.clipsToBounds = YES;
        _dateLabel.font = [UIFont systemFontOfSize:11.0f];
        [self.contentView addSubview:_dateLabel];
    }
    return _dateLabel;
}

- (UIImageView *)avatar
{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW - ICONW - Margin, CGRectGetMaxY(self.dateLabel.frame) + Margin * 2, ICONW, ICONW)];
        _avatar.layer.cornerRadius = ICONW * 0.5;
        _avatar.layer.borderWidth = 0;
        _avatar.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _avatar.clipsToBounds = YES;
        _avatar.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_avatar];
    }
    return _avatar;
}

- (UIImageView *)contentBg
{
    if (!_contentBg) {
        _contentBg = [[UIImageView alloc] initWithFrame:CGRectMake(ICONW + Margin * 2, CGRectGetMaxY(self.dateLabel.frame) + Margin, SCREENW - IMAGEW, IMAGEW)];
        [self.contentView addSubview:_contentBg];
    }
    return _contentBg;
}

- (UIButton *)contentImage
{
    if (!_contentImage) {
        _contentImage = [[UIButton alloc] initWithFrame:CGRectMake(SCREENW - PADDING - IMAGEW - Margin - OFFSET, CGRectGetMaxY(self.dateLabel.frame) + Margin * 2, IMAGEW, IMAGEW)];
        _contentImage.layer.cornerRadius = 5.0f;
        _contentImage.clipsToBounds = YES;
        
        [self.contentView addSubview:_contentImage];
    }
    return _contentImage;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, SCREENW - 180, 60)];
        _contentLabel.font = [UIFont systemFontOfSize:18];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
