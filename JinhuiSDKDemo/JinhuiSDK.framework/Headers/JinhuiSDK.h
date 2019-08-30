//
//  JinhuiSDK.h
//  JinhuiSDK
//
//  Created by mshqiu on 2019/8/22.
//

#import <UIKit/UIKit.h>

@protocol JinhuiSDKEventListener <NSObject>

// SDK通过此方法向app派发事件
- (void)handleEventWithId:(NSString *)id type:(NSString *)type data:(NSDictionary *)data;

@end

@interface JinhuiSDK : NSObject

+ (NSString *)version;

// 设置渠道appKey及appSecret
+ (void)setAppKey:(NSString *)appKey appSecret:(NSString *)appSecret;
// 设置环境，YES：生产 NO：测试，默认NO
+ (void)setEnvironmentMode:(BOOL)production;
// 设置扩展参数
+ (void)setParams:(NSDictionary *)params;
// 设置事件监听对象
+ (void)setEventListener:(id<JinhuiSDKEventListener>)eventListener;
// 事件回调
+ (void)eventCallbackWithId:(NSString *)id message:(NSDictionary *)message data:(NSDictionary *)data;

// 登录
/** 用户信息userInfo字段说明如下
 *  name        :   用户姓名
 *  idNo        :   身份证号
 *  mobile      :   手机号
 *  bankAccount :   华创资金账号
 */
+ (void)login:(NSDictionary *)userInfo;
// 退出登录
+ (void)logout;

// 创建指定路由url的controller页面
+ (UIViewController *)pageWithUrl:(NSString *)url params:(NSDictionary *)params;
// 打开指定路由url的controller页面
+ (void)push:(NSString *)url params:(NSDictionary *)params;


@end
