//
//  BeforeScanSingleton.h
//
//  Created by liwei on 17/3/24.
//  Copyright © 2017年 liwei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *@brief 扫码类型
 */
typedef enum ScanStyle
{
    QQStyle,         /**< QQ扫码类型 */
    AliPayStyle,      /**< 支付宝扫码类型 */
    WeChatStyle       /**< 微信扫码类型 */
}ScanStyle;

@interface BeforeScanSingleton : NSObject

/**
 *@brief    生成一个单例
 *@return   BeforeScanSingleton类
 */
+ (BeforeScanSingleton *)shareScan;

/**
 *@brief   传递参数 并跳转页面
 *@param   type   所需要展示的扫码类型
 *@param   vc     当前的 viewcontroller
 *@return  void
 */
- (void)ShowSelectedType:(ScanStyle)type WithViewController:(UIViewController *)vc;

@end
