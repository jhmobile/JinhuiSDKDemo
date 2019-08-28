//
//  TabBarController.m
//  JinhuiSDK_Example
//
//  Created by mshqiu on 2019/8/22.
//  Copyright © 2019 mshqiu. All rights reserved.
//

#import "TabBarController.h"
#import <JinhuiSDK/JinhuiSDK.h>
#import "User.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "MineViewController.h"

@interface TabBarController () <UITabBarControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) NSUInteger lastIndex;
@property (nonatomic, assign) NSUInteger targetIndex;

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UIViewController *vc0 = [self wrapViewController:[[HomeViewController alloc] init] tabItemTitle:@"首页"];
    UIViewController *vc1 = [self wrapViewController:[JinhuiSDK pageWithUrl:@"/" params:nil] tabItemTitle:@"产品"];
    UIViewController *vc2 = [self wrapViewController:[[MineViewController alloc] init] tabItemTitle:@"我的"];
    
    self.viewControllers = @[vc0, vc1, vc2];
    
    self.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([User currentUser] && self.lastIndex != self.targetIndex) {
        self.selectedIndex = self.targetIndex;
        self.lastIndex = self.targetIndex;
    } else {
        self.targetIndex = self.lastIndex;
    }
}

- (UINavigationController *)wrapViewController:(UIViewController *)vc tabItemTitle:(NSString *)tabItemTitle {
    vc.navigationItem.title = tabItemTitle;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]} forState:UIControlStateSelected];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor]} forState:UIControlStateNormal];
    nav.tabBarItem.title = tabItemTitle;
    
    return nav;
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    self.targetIndex = [tabBarController.viewControllers indexOfObject:viewController];
    
    if ([tabBarController.viewControllers indexOfObject:viewController] == tabBarController.viewControllers.count-1) {
        if (![User currentUser]) {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [tabBarController presentViewController:nav animated:YES completion:nil];
            return NO;
        }
    }
    
    self.lastIndex = [tabBarController.viewControllers indexOfObject:viewController];
    
    return true;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
