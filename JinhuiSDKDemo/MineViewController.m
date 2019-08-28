//
//  MineViewController.m
//  JinhuiSDK_Example
//
//  Created by mshqiu on 2019/8/22.
//  Copyright © 2019 mshqiu. All rights reserved.
//

#import "MineViewController.h"
#import "User.h"

@interface MineViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.label = [[UILabel alloc] init];
    [self.view addSubview:self.label];
    
    self.label.numberOfLines = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    User *user = [User currentUser];
    
    NSString *str = [NSString stringWithFormat:@"姓名：%@\n手机号：%@\n身份证号：%@\n华创资金账号：%@", user.name, user.mobile, user.idNo, user.bankAccount];
    self.label.text = str;
    [self.label sizeToFit];
    self.label.center = self.view.center;
}

- (void)logout {
    [User logout];
    
    if (self.tabBarController) {
        self.tabBarController.selectedIndex = 0;
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
