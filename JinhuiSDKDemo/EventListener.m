//
//  EventListener.m
//  JinhuiSDK_Example
//
//  Created by mshqiu on 2019/8/22.
//  Copyright © 2019 mshqiu. All rights reserved.
//

#import "EventListener.h"
#import "LoginViewController.h"
#import "RiskViewController.h"

@implementation EventListener

static EventListener *instance;
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)handleEventWithId:(NSString *)id type:(NSString *)type data:(NSDictionary *)data {
    NSLog(@"EventListener: %@", type);
    
    if ([type isEqualToString:@"login"]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.eventId = id;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:nil];
    } else if ([type isEqualToString:@"risk"]) {
        RiskViewController *vc = [[RiskViewController alloc] init];
        vc.eventId = id;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:nil];
    }
}

@end
