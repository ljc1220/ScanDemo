//
//  BeforeScanSingleton.m
//
//  Created by liwei on 17/3/24.
//  Copyright © 2017年 liwei. All rights reserved.
//

#import "BeforeScanSingleton.h"
#import "LBXScanView.h"
#import "SubLBXScanViewController.h"

static BeforeScanSingleton *_beforeScan;
@interface BeforeScanSingleton ()
@property (strong, nonatomic) UIViewController *viewController;
@end
@implementation BeforeScanSingleton

+ (BeforeScanSingleton *)shareScan {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _beforeScan = [[BeforeScanSingleton alloc]init];
    });
    return _beforeScan;
}

- (void)ShowSelectedType:(ScanStyle)type WithViewController:(UIViewController *)vc {
    
    if (![self cameraPemission])
    {
        [self showError:@"没有摄像机权限"];
        return ;
    }
    _viewController = vc;
    UIBarButtonItem *backBar = [UIBarButtonItem new];
    backBar.title = @"";
    _viewController.navigationItem.backBarButtonItem = backBar;
    
    switch (type) {
        case QQStyle:
            [self QQStyleScan];
            break;
        case AliPayStyle:
            [self AlipayStyleScan];
            break;
        case WeChatStyle:
            [self WeChatStyleScan];
        default:
            break;
    }
}
#pragma mark - 检测是否有权限打开相机
- (BOOL)cameraPemission
{
    BOOL isHavePemission = NO;
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                isHavePemission = YES;
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                break;
            case AVAuthorizationStatusNotDetermined:
                isHavePemission = YES;
                break;
        }
    }
    return isHavePemission;
}

#pragma mark - 提示框
- (void)showError:(NSString*)str
{
    [LBXAlertAction showAlertWithTitle:@"提示" msg:str chooseBlock:nil buttonsStatement:@"知道了",nil];
}

#pragma mark - QQ类型扫码
- (void)QQStyleScan
{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    vc.isVideoZoom = YES;
    [_viewController.navigationController pushViewController:vc animated:YES];
//    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
//    [window addSubview:vc.view];
}

#pragma mark - 支付宝类型扫码
- (void)AlipayStyleScan
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 60;
    style.xScanRetangleOffset = 30;
    
    if ([UIScreen mainScreen].bounds.size.height <= 480 )
    {
        //3.5inch 显示的扫码缩小
        style.centerUpOffset = 40;
        style.xScanRetangleOffset = 20;
    }
    
    
    style.alpa_notRecoginitonArea = 0.6;
    
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2.0;
    style.photoframeAngleW = 16;
    style.photoframeAngleH = 16;
    
    style.isNeedShowRetangle = NO;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    //使用的支付宝里面网格图片
    UIImage *imgFullNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_full_net"];
    
    
    style.animationImage = imgFullNet;
    
    
    [self openScanVCWithStyle:style];
}
#pragma mark - 微信类型扫码
- (void)WeChatStyleScan
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2;
    style.photoframeAngleW = 18;
    style.photoframeAngleH = 18;
    style.isNeedShowRetangle = YES;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    style.colorAngle = [UIColor colorWithRed:0./255 green:200./255. blue:20./255. alpha:1.0];
    
    
    //qq里面的线条图片
    UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_Scan_weixin_Line"];
    
    // imgLine = [self createImageWithColor:[UIColor colorWithRed:120/255. green:221/255. blue:71/255. alpha:1.0]];
    
    style.animationImage = imgLine;
    
    [self openScanVCWithStyle:style];
}

- (void)openScanVCWithStyle:(LBXScanViewStyle*)style
{
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    //vc.isOpenInterestRect = YES;
    [_viewController.navigationController pushViewController:vc animated:YES];
}

@end
