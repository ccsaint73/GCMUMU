//
//  GCQrCodeController.m
//  GCMUMU
//
//  Created by 郭存 on 15/12/10.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "GCQrCodeController.h"
#import <AVFoundation/AVFoundation.h>

@interface GCQrCodeController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) UIImageView *scanLine;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, assign) BOOL isUp;

@end

@implementation GCQrCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self createQrCode];
}

- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"二维码";
    
    // 创建扫描框
    UIImageView *scanKuang = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENW - 200) * 0.5, (SCREENH - 200) * 0.5 - 50, 200, 200)];
    // 添加图片
    scanKuang.image = [UIImage imageNamed:@"HR_border"];
    
    [self.view addSubview:scanKuang];
    
    // 创建扫描线
    UIImageView *scanLine = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENW - 200) * 0.5, (SCREENH - 200) * 0.5 - 50, 200, 10)];
    scanLine.image = [UIImage imageNamed:@"HR_scan_line"];
    [self.view addSubview:scanLine];
    _scanLine = scanLine;
    
    // 增加动画
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(showAnimation)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _link = link;
}

- (void)showAnimation
{
    // 拿到扫描线的y坐标
    CGFloat lineY = _scanLine.frame.origin.y;
    
    if (_isUp) {
        lineY --;
    }else {
        lineY ++;
    }
    
    if (lineY > SCREENH * 0.5 + 40) {
        _isUp = YES;
    }else if (lineY < (SCREENH - 200) * 0.5 - 50) {
        _isUp = NO;
    }
    
    _scanLine.frame = CGRectMake((SCREENW - 200) * 0.5, lineY, 200, 10);
}

- (void)createQrCode
{
    // 1.拿到设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2.设置输入
    NSError *error = nil;
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if (!error) {
        // 3.设置输出
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // 4.创建会话
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        _session = session;
        [session addInput:input];
        [session addOutput:output];
        
        // 4.1设置输出类型
        [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
        
        // 6.增加透视层
        AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
        layer.frame = self.view.bounds;
        [self.view.layer insertSublayer:layer atIndex:0];
        
        // 5.开始扫描
        [session startRunning];
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        [_session stopRunning];
        _link.paused = YES;
        
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects lastObject];
        NSString *str = obj.stringValue;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }
}

@end
