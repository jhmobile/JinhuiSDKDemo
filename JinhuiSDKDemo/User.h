//
//  User.h
//  JinhuiSDK_Example
//
//  Created by mshqiu on 2019/8/22.
//  Copyright © 2019 mshqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *idNo;
@property (nonatomic, copy) NSString *bankAccount;


+ (User *)currentUser;
+ (User *)login:(NSDictionary *)userInfo;
+ (void)logout;

@end

NS_ASSUME_NONNULL_END
