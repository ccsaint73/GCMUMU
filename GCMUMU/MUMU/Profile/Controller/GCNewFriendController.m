//
//  GCNewFriendController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/21.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCNewFriendController.h"
#import "EaseMob.h"

@interface GCNewFriendController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *dict;

@end

@implementation GCNewFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupData];
}

- (void)setupUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)setupData
{
    _dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"buddy"];
}

#pragma
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"tabbar_meHL"];
    cell.textLabel.text = _dict[@"username"];
    cell.detailTextLabel.text = _dict[@"message"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager acceptBuddyRequest:_dict[@"username"] error:&error];
    if (isSuccess && !error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"添加好友成功！" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma 
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH - 64) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
