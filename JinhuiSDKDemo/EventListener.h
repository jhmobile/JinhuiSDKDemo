//
//  EventListener.h
//  JinhuiSDK_Example
//
//  Created by mshqiu on 2019/8/22.
//  Copyright © 2019 mshqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JinhuiSDK/JinhuiSDK.h>

@interface EventListener : NSObject <JinhuiSDKEventListener>

+ (instancetype)shared;

@end
