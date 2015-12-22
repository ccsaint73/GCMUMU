//
//  GCChatController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/22.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCChatController.h"
#import "GCChatBottomView.h"
#import "Easemob.h"

@interface GCChatController () <IChatManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) GCChatBottomView *replyView;

@end

@implementation GCChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 设置代理监听
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    // 设置底部view
    GCChatBottomView *view = [[[NSBundle mainBundle] loadNibNamed:@"GCChatBottomView" owner:self options:nil] lastObject];
    view.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREENW, 49);
   
    __weak typeof(self) ws = self;
    
    view.messageDidSend = ^(NSString *message){
        [ws sendTextMessage:message];
    };

    [self.view addSubview:view];
    _replyView = view;
    
    // 设置键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)sendTextMessage:(NSString *)textMsg
{
    EMChatText *txtChat = [[EMChatText alloc] initWithText:textMsg];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:txtChat];
    
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithReceiver:_conversion.chatter bodies:@[body]];
    message.messageType = eMessageTypeChat; // 设置为单聊消息
    
    // 发送
    EMError *error = nil;
    [[EaseMob sharedInstance].chatManager sendMessage:message progress:nil error:&error];
    
    if (!error) {
        [_replyView resetMessageField];
        [self refreshUI];
    }
}

- (void)setConversion:(EMConversation *)conversion
{
    _conversion = conversion;
    
    _messages = [_conversion loadAllMessages];
    
    [self.tableView reloadData];
}

- (void)refreshUI
{
    _messages = [_conversion loadAllMessages];
    
    [self.tableView reloadData];
}

- (void)didKeyboardShow:(NSNotification *)noti
{
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.25f animations:^{
        self.tableView.frame = CGRectMake(0, 64, SCREENW, self.view.frame.size.height - frame.size.height - 49 - 64);
        self.replyView.frame = CGRectMake(0, CGRectGetMaxY(_tableView.frame), SCREENW, 49);
        
        if (_messages.count > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_messages.count - 1 inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }];
}

- (void)didKeyboardHide:(NSNotification *)noti
{
    [UIView animateWithDuration:0.25f animations:^{
        self.tableView.frame = CGRectMake(0, 64, SCREENW, self.view.frame.size.height - 49 - 64);
        self.replyView.frame = CGRectMake(0, CGRectGetMaxY(_tableView.frame), SCREENW, 49);
    }];
}


#pragma mark
// 接收到的信息
- (void)didReceiveMessage:(EMMessage *)message
{
    _messages = [_conversion loadAllMessages];
    
    [self.tableView reloadData];
}

#pragma mark
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    
    // 获取消息
    EMMessage *message = _messages[indexPath.row];
    cell.textLabel.text = message.from;
    
    // 展示消息
    EMTextMessageBody *body = [message.messageBodies lastObject];
    cell.detailTextLabel.text = body.text;
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH - 64 - 49) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)dealloc
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

@end