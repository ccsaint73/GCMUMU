//
//  GCAddController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/17.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCAddController.h"
#import "EaseMob.h"
#import "Friend.h"

@interface GCAddController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *infos;

@end

@implementation GCAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInit];
    [self setupData];
}

- (void)setupInit
{
    self.title = @"添加联系人";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
}

- (void)setupData
{
    NSArray *array = @[@"ceshi1", @"ceshi2", @"ceshi3"];
    
    for (NSString *str in array) {
        [_infos addObject:str];
    }
    
    [self.tableView reloadData];
}

// 点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    [self addBuddy:searchBar.text];
}

#pragma mark --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    NSString *username = _infos[indexPath.row];
    cell.textLabel.text = username;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取用户信息
    NSString *username = _infos[indexPath.row];
    
    [self addBuddy:username];
}

- (void)addBuddy:(NSString *)username
{
    // 申请好友添加
    EMError *error;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:username message:@"我想加您为好友" error:&error];
    if (isSuccess && !error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发送请求成功！" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.description delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }
}

// 隐藏键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark -- --
- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, SCREENW, 44)];
        [self.view addSubview:_searchBar];
    }
    
    return _searchBar;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), SCREENW, SCREENH - 64 - 44 - 49) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)infos
{
    if (!_infos) {
        _infos = [NSMutableArray array];
    }
    return _infos;
}

@end








