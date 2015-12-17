//
//  GCSessionController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/9.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCSessionController.h"
#import "GCQrCodeController.h"
#import "EaseMob.h"

@interface GCSessionController ()

@property (nonatomic, strong) NSArray *conversations;

@end

@implementation GCSessionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航栏
    [self setupNav];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 获取数据库里所有的对话
    _conversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
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

@end











