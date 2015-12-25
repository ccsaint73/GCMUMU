//
//  GCSettingController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/23.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCSettingController.h"

@interface GCSettingController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation GCSettingController

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
    _items = [NSMutableArray array];
    
    NSArray *first = @[@"账号安全"];
    NSArray *second = @[@"新消息", @"通用"];
    NSArray *thred = @[@"关于我们"];
    NSArray *forth = @[@"退出登陆"];
    
    [_items addObject:first];
    [_items addObject:second];
    [_items addObject:thred];
    [_items addObject:forth];
    
    [self.tableView reloadData];
}

#pragma mark -- 代理方法 --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *infos = _items[section];
    return infos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GCDiscoverCell" owner:self options:nil] lastObject];
    }
    
    // 获取数据
    NSArray *infos = _items[indexPath.section];
    NSString *str = infos[indexPath.row];
    
    // 设置cell
    cell.textLabel.text = str;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

#pragma mark 
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end










