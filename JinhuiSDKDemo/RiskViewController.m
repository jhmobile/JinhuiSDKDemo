//
//  RiskViewController.m
//  JinhuiSDK_Example
//
//  Created by mshqiu on 2019/8/23.
//  Copyright © 2019 mshqiu. All rights reserved.
//

#import "RiskViewController.h"
#import <JinhuiSDK/JinhuiSDK.h>

@interface RiskViewController ()

@end

@implementation RiskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"风险测评";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"完成测评" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onFinish) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    [self.view addSubview:button];
    button.center = self.view.center;
}

- (void)onFinish {
    if (self.eventId) {
        [JinhuiSDK eventCallbackWithId:self.eventId message:@{@"code": @"0"} data:nil];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



@end
