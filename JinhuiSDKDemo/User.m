//
//  User.m
//  JinhuiSDK_Example
//
//  Created by mshqiu on 2019/8/22.
//  Copyright © 2019 mshqiu. All rights reserved.
//

#import "User.h"
#import <JinhuiSDK/JinhuiSDK.h>

static NSString *UserInfoPersistencyKey = @"com.JinhuiSDKDemo.userInfo";

@implementation User

static User *currentUser;
+ (User *)currentUser {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!currentUser) {
            NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:UserInfoPersistencyKey];
            currentUser = [User login:userInfo];
        }
    });
    return currentUser;
}

+ (User *)login:(NSDictionary *)userInfo {
    User *user = [[User alloc] init];
    [user setValuesForKeysWithDictionary:userInfo];
    
    if (user.name.length && user.idNo.length && user.mobile.length && user.bankAccount.length) {
        currentUser = user;
        [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:UserInfoPersistencyKey];
        
        [JinhuiSDK login:userInfo];
    } else {
        currentUser = nil;
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:UserInfoPersistencyKey];
        
        [JinhuiSDK logout];
    }
    
    return currentUser;
}

+ (void)logout {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:UserInfoPersistencyKey];
    currentUser = nil;
    
    [JinhuiSDK logout];
}

@end
