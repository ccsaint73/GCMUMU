//
//  GCChatController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/21.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCChatController.h"
#import "Easemob.h"

@interface GCChatController () <IChatManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GCChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark 
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH - 64 - 49) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end










