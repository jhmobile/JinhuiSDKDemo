//
//  LoginViewController.m
//  JinhuiSDK_Example
//
//  Created by mshqiu on 2019/8/22.
//  Copyright © 2019 mshqiu. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import <JinhuiSDK/JinhuiSDK.h>
#import <Masonry/Masonry.h>

@interface LoginViewController ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *mobileLabel;
@property (nonatomic, strong) UILabel *bankAccountLabel;
@property (nonatomic, strong) UILabel *idNoLabel;

@property (strong, nonatomic) UITextField *nameInput;
@property (strong, nonatomic) UITextField *mobileInput;
@property (strong, nonatomic) UITextField *bankAccountInput;
@property (strong, nonatomic) UITextField *idNoInput;

@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation LoginViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = item;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"快捷填充" style:UIBarButtonItemStyleDone target:self action:@selector(fill)];
    self.navigationItem.rightBarButtonItem = item1;
    
    self.nameLabel = [self createLabelWithText:@"姓名:"];
    self.mobileLabel = [self createLabelWithText:@"手机号:"];
    self.idNoLabel = [self createLabelWithText:@"身份证号:"];
    self.bankAccountLabel = [self createLabelWithText:@"华创资金账号:"];
    
    self.nameInput = [self createTextField];
    self.mobileInput = [self createTextField];
    self.bankAccountInput = [self createTextField];
    self.idNoInput = [self createTextField];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.idNoLabel];
    [self.view addSubview:self.mobileLabel];
    [self.view addSubview:self.bankAccountLabel];
    [self.view addSubview:self.nameInput];
    [self.view addSubview:self.mobileInput];
    [self.view addSubview:self.idNoInput];
    [self.view addSubview:self.bankAccountInput];
    [self.view addSubview:self.loginButton];
    
    CGFloat margin = 15;
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(margin);
        make.top.equalTo(self.view).offset(100);
    }];
    [self.nameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.left.right.equalTo(self.bankAccountInput);
    }];
    
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(margin);
    }];
    [self.mobileInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mobileLabel);
        make.left.right.equalTo(self.bankAccountInput);
    }];
    
    [self.idNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mobileLabel);
        make.top.equalTo(self.mobileLabel.mas_bottom).offset(margin);
    }];
    [self.idNoInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.idNoLabel);
        make.left.right.equalTo(self.bankAccountInput);
    }];
    
    [self.bankAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.idNoLabel);
        make.top.equalTo(self.idNoLabel.mas_bottom).offset(margin);
    }];
    [self.bankAccountInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankAccountLabel.mas_right).offset(margin);
        make.right.equalTo(self.view).offset(-margin);
        make.centerY.equalTo(self.bankAccountLabel);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.bankAccountInput.mas_bottom).offset(30);
    }];
}

- (void)cancel {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    if (self.eventId) {
        [JinhuiSDK eventCallbackWithId:self.eventId message:@{@"code": @"-1", @"message": @"用户取消登录"} data:nil];
    }
}

- (void)fill {
    self.nameInput.text = @"卫子夫";
    self.mobileInput.text = @"18515279796";
    self.idNoInput.text = @"110000197603217303";
    self.bankAccountInput.text = @"10004695";
}

- (IBAction)login:(id)sender {
    NSDictionary *userInfo = @{
                               @"name": self.nameInput.text?:@"",
                               @"mobile": self.mobileInput.text?:@"",
                               @"bankAccount":self.bankAccountInput.text?:@"",
                               @"idNo":self.idNoInput.text?:@""
                               };
    User *user = [User login:userInfo];
    if (self.eventId) {
        if (user) {
            [JinhuiSDK eventCallbackWithId:self.eventId message:@{@"code": @"0"} data:userInfo];
        } else {
            [JinhuiSDK eventCallbackWithId:self.eventId message:@{@"code": @"-1"} data:nil];
        }
    }
    
    if (!user) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (UILabel *)createLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    return label;
}

- (UITextField *)createTextField {
    UITextField *t = [[UITextField alloc] init];
    t.borderStyle = UITextBorderStyleRoundedRect;
    [t setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    return t;
}

@end
