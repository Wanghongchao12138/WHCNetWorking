//
//  ViewController.m
//  WHCNetWorking
//
//  Created by 王红超 on 2018/1/23.
//  Copyright © 2018年 WHC. All rights reserved.
//

#import "ViewController.h"
#import "WHCNetWorkManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[WHCNetWorkManager sharedInstance] getNowNetWorkingStatusSuccessBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"当前的网络状态是  %ld",status);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
