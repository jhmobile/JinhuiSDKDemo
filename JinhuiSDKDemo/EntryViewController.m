//
//  EntryViewController.m
//  JinhuiSDK_Example
//
//  Created by mshqiu on 2019/8/26.
//  Copyright © 2019 mshqiu. All rights reserved.
//

#import "EntryViewController.h"
#import "TabBarController.h"
#import "HomeViewController.h"
#import <JinhuiSDK/JinhuiSDK.h>

@interface EntryViewController ()

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"切换场景";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.tag = 0;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.numberOfLines = 0;
    [button setTitle:@"场景一：\n金汇页面作为\nTabBarController\n一级页面" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    [self.view addSubview:button];
    button.center = self.view.center;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.tag = 1;
    button1.titleLabel.textAlignment = NSTextAlignmentCenter;
    button1.titleLabel.numberOfLines = 0;
    [button1 setTitle:@"场景二：\n金汇页面作为\nNavigationController\n二级页面" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 sizeToFit];
    [self.view addSubview:button1];
    CGPoint point = self.view.center;
    point.y += 100;
    button1.center = point;
}

- (void)onButtonClick:(UIButton *)button {
    
    switch (button.tag) {
        case 0:
        {
            TabBarController *vc = [[TabBarController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        }
            break;
        case 1:
        {
            HomeViewController *vc = [[HomeViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        }
            break;
        default:
            break;
    }
}

@end
