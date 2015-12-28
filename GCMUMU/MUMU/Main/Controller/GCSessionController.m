//
//  GCSessionController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/9.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCSessionController.h"
#import "GCQrCodeController.h"
#import "GCConversionCell.h"
#import "GCChatController.h"
#import "EaseMob.h"

@interface GCSessionController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate>

// 搜索控制器
@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSArray *conversations;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GCSessionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航栏
    [self setupNav];
    [self setupUI];
}

- (void)setupUI
{
    // 设置search的代理
    // 创建搜索控制器
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    // 设置搜索框颜色
    self.searchController.searchBar.barTintColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    // 设置搜索回调
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    
    //
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 获取数据库里所有的对话
    _conversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
    
    [self.tableView reloadData];
}

#pragma mark -- --

- (void)setupNav
{
    // 设置左上角
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Nav_qrcode"] style:UIBarButtonItemStyleDone target:self action:@selector(leftItemDidSelected)];
    leftItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftItemDidSelected
{
    // 跳转二维码
    GCQrCodeController *qrCode = [[GCQrCodeController alloc] init];
    qrCode.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:qrCode animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // 获取要搜索的文字
    NSString *searchString = self.searchController.searchBar.text;
    
    // 刷新数据
    [self.tableView reloadData];
}

#pragma mark -- 代理方法 --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _conversations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"";
    GCConversionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GCConversionCell" owner:self options:nil] lastObject];
    }
    
    EMConversation *conversion = _conversations[indexPath.row];
    cell.titleLabel.text = conversion.chatter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GCChatController *chat = [[GCChatController alloc] init];
    EMConversation *conversion = _conversations[indexPath.row];
    chat.conversion = conversion;
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark --

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), SCREENW, SCREENH - 64 - 44 - 49) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end











