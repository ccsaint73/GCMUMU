//
//  GCProfileController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/9.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCProfileController.h"
#import "GCAddController.h"
#import "EaseMob.h"
#import "FriendCell.h"
#import "GCTabBarController.h"
#import "GCNewFriendController.h"
#import "AppDelegate.h"

@interface GCProfileController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *infos;

@end

@implementation GCProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 获取好友列表
    [self getBuddyList];
}

- (void)setupNav
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemDidSelected)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
}

- (void)rightItemDidSelected
{
    // 创建添加联系人
    GCAddController *addVC = [[GCAddController alloc] init];
    addVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)getBuddyList
{
    // 获取好友列表
    [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
        if (!error) {
            [self.infos removeAllObjects];
            
            for (EMBuddy *buddy in buddyList) {
                [self.infos addObject:buddy.username];
            }
            
            [self.tableView reloadData];
        }
    } onQueue:nil];
}

#pragma mark -- 代理方法 --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else {
        return _infos.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"";
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendCell" owner:self options:nil] lastObject];
    }
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.iconImage.image = [UIImage imageNamed:@"ff_iconAdd"];
                cell.titleLabel.text = NSLocalizedString(@"new", nil);
                break;
            case 1:
                cell.iconImage.image = [UIImage imageNamed:@"addgroup"];
                cell.titleLabel.text = NSLocalizedString(@"group", nil);
                break;
            default:
                break;
        }
        
    }else {
        cell.iconImage.image = [UIImage imageNamed:@"tabbar_meHL"];
        cell.titleLabel.text = _infos[indexPath.row];
    }
    
    // 去掉点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                GCNewFriendController *new = [[GCNewFriendController alloc] init];
                [self.navigationController pushViewController:new animated:YES];
            }
                break;
            case 1:
            {
                
            }
                break;
            default:
                break;
        }
    }else {
        // 添加对话
        [[EaseMob sharedInstance].chatManager conversationForChatter:_infos[indexPath.row] conversationType:eConversationTypeChat];
        
        // 跳转页面
        GCTabBarController *tabBar = (GCTabBarController *)((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
        [tabBar setBtnWithTag:0];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"测试";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat viewH;
    
    if (section == 0) {
        viewH = 1;
    }else {
        viewH = 20;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, viewH)];
    return view;
}

#pragma mark
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), SCREENW, SCREENH - 64 - 44 - 49) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, SCREENW, 44)];
        [self.view addSubview:_searchBar];
    }
    
    return _searchBar;
}

- (NSMutableArray *)infos
{
    if (!_infos) {
        _infos = [NSMutableArray array];
    }
    return _infos;
}

@end




