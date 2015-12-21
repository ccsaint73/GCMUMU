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
#import "EaseMob.h"

@interface GCSessionController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

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
    self.searchBar.delegate = self;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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

#pragma mark --
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end











