//
//  HomeViewController.m
//  JinhuiSDK
//
//  Created by mshqiu on 08/21/2019.
//  Copyright (c) 2019 mshqiu. All rights reserved.
//

#import "HomeViewController.h"
#import <JinhuiSDK/JinhuiSDK.h>
#import "EntryViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"
#import "User.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"切换场景" style:UIBarButtonItemStyleDone target:self action:@selector(switchScene)];
    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"查看理财产品" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    [self.view addSubview:button];
    button.center = self.view.center;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.tabBarController) {
        NSString *title;
        if ([User currentUser]) {
            title = @"我的";
        } else {
            title = @"登录";
        }
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(switchToMine)];
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)switchScene {
    UIViewController *vc = [[EntryViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [[UIApplication sharedApplication] keyWindow].rootViewController = nav;
}

- (void)switchToMine {
    if ([User currentUser]) {
        MineViewController *vc = [[MineViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)onButtonClick {
    if (self.tabBarController) {
        self.tabBarController.selectedIndex = 1;
    } else {
        [JinhuiSDK push:@"/" params:nil];
    }
}

@end
