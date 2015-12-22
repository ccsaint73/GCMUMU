//
//  GCDiscoverController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/9.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCDiscoverController.h"
#import "GCDiscoverCell.h"
#import "GCInfo.h"

@interface GCDiscoverController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *infos;

@end

@implementation GCDiscoverController

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

// 创建假数据
- (void)setupData
{
    _infos = [NSMutableArray array];
    
    // 设置图标，文字，跳转类
    NSArray *images = @[@"ShowAlbum", @"Location_HL", @"food", @"qrcode", @"video", @"MoreSetting"];
    NSArray *titles = @[@"分享", @"地图", @"扫一扫", @"餐饮", @"电影", @"设置"];
    NSArray *classes = @[@"GCQrCodeController", @"GCQrCodeController", @"GCQrCodeController", @"GCQrCodeController", @"GCQrCodeController", @"GCQrCodeController"];
    
    // 给子数组赋值
    NSMutableArray *fitems = [NSMutableArray array];
    NSMutableArray *sitems = [NSMutableArray array];
    NSMutableArray *titems = [NSMutableArray array];
    NSMutableArray *ritems = [NSMutableArray array];
    
    for (int i = 0; i < 1; i ++) {
        GCInfo *item = [[GCInfo alloc] init];
        item.image = images[i];
        item.title = titles[i];
        item.className = classes[i];
        [fitems addObject:item];
    }
    
    for (int i = 0; i < 2; i ++) {
        GCInfo *item = [[GCInfo alloc] init];
        item.image = images[i + 1];
        item.title = titles[i + 1];
        item.className = classes[i + 1];
        [sitems addObject:item];
    }
    
    for (int i = 0; i < 1; i ++) {
        GCInfo *item = [[GCInfo alloc] init];
        item.image = images[i + 3];
        item.title = titles[i + 3];
        item.className = classes[i + 3];
        [titems addObject:item];
    }
    
    for (int i = 0; i < 1; i ++) {
        GCInfo *item = [[GCInfo alloc] init];
        item.image = images[i + 5];
        item.title = titles[i + 5];
        item.className = classes[i + 5];
        [ritems addObject:item];
    }

    [_infos addObject:fitems];
    [_infos addObject:sitems];
    [_infos addObject:titems];
    [_infos addObject:ritems];
    
    // 刷新数据
    [self.tableView reloadData];
}

#pragma mark -- 代理方法 --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _infos.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *items = _infos[section];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"";
    GCDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GCDiscoverCell" owner:self options:nil] lastObject];
    }
    
    // 获取数据
    NSArray *items = _infos[indexPath.section];
    GCInfo *info = items[indexPath.row];
    
    // 展示数据
    cell.iconImage.image = [UIImage imageNamed:info.image];
    cell.titleLabel.text = info.title;
    
    // 去掉点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 拿到对应的数据
    NSArray *items = _infos[indexPath.section];
    GCInfo *info = items[indexPath.row];
    
    // 跳转页面
    Class c = NSClassFromString(info.className);
    UIViewController *vc = [[c alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

#pragma mark -- 懒加载 --
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
