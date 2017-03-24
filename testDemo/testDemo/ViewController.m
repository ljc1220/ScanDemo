//
//  ViewController.m
//  testDemo
//
//  Created by liwei on 17/3/24.
//  Copyright © 2017年 liwei. All rights reserved.
//

#import "ViewController.h"
#import "BeforeScanSingleton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (IBAction)QQ:(UIButton *)sender {
    
    [[BeforeScanSingleton shareScan] ShowSelectedType:QQStyle WithViewController:self];
    
}
- (IBAction)Alipay:(UIButton *)sender {
    
    [[BeforeScanSingleton shareScan] ShowSelectedType:AliPayStyle WithViewController:self];
    
}
- (IBAction)Wechat:(UIButton *)sender {
    
    [[BeforeScanSingleton shareScan] ShowSelectedType:WeChatStyle WithViewController:self];
    
}

@end
