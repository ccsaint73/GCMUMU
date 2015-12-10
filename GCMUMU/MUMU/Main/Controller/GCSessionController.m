//
//  GCSessionController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/9.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCSessionController.h"
#import "GCQrCodeController.h"

@interface GCSessionController ()

@end

@implementation GCSessionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
}

- (void)setupNav
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Nav_qrcode"] style:UIBarButtonItemStyleDone target:self action:@selector(leftItemDidSelected)];
    leftItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftItemDidSelected
{
    GCQrCodeController *qrCode = [[GCQrCodeController alloc] init];
    qrCode.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:qrCode animated:YES];
}

@end











