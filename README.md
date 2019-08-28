# 金汇金融业务SDK集成文档
* 文档维护人：邱敏舜

## 一、集成环境
* iOS 8+

## 二、集成示例及API说明
#### CocoaPods集成
Podfile
```
source 'https://github.com/CocoaPods/Specs.git'
source 'git@gitlab.jinhui365.cn:iOS/JHJRSpecs.git'

target 'your target' do

    pod 'JinhuiSDK'

end
```

#### 初始化
```
// AppDelegate.m

    // 设置渠道信息
    [JinhuiSDK setAppKey:@"jh0cbc916c0191b606" appSecret:@"47a44def5315c96b94819b10e69808e5"];
    //设置环境，YES：生产 NO：测试，默认NO
    [JinhuiSDK setEnvironmentMode:NO];
    // 设置SDK事件监听对象
    [JinhuiSDK setEventListener:[EventListener shared]];
    // 额外参数（可选，非必须）
    [JinhuiSDK setParams:@{@"themeColor": @"#ff6600"}];

    if ([User currentUser]) {
        NSDictionary *userInfo = @{
        @"name": [User currentUser].name,
        @"mobile": [User currentUser].mobile,
        @"bankAccount":  [User currentUser].bankAccount,
        @"idNo": [User currentUser].idNo
        };
        // 登录SDK
        [JinhuiSDK login:userInfo];
    } else {
        // 退出登录SDK
        [JinhuiSDK logout];
    }
```
#### 获取页面对象
```
// 创建指定路由url的controller页面，用于集成至TabBarController中作为一级页面
UIViewController *vc = [JinhuiSDK pageWithUrl:@"/product" params:params];
```
#### 打开页面
```
// 打开指定路由url的controller页面，用这种方式打开二级页面
[JinhuiSDK push:@"/product" params:params];
```
#### 登录
```
// 给SDK设置已登录的用户信息
[JinhuiSDK login:@{
@"name": @"卫子夫", 
@"idNo": @"110000197603217303",
@"mobile": @"18515279796",
@"bankAccount": @"10004695"
}];
```
* 用户信息字段最小集及其含义

#### 退出登录
```
// 用户退出登录，应调用SDK方法退出登录
[JinhuiSDK logout];
```
#### 事件监听及回调

* 事件监听处理

```
@protocol JinhuiSDKEventListener <NSObject>
- (void)handleEventWithId:(NSString *)id type:(NSString *)type data:(NSDictionary *)data;
@end

// EventListener.h
@interface EventListener : NSObject <JinhuiSDKEventListener>
@end

// EventListener.m
@implementation EventListener
- (void)handleEventWithId:(NSString *)id type:(NSString *)type data:(NSDictionary *)data{
    if ([eventName isEqualToString:@"login"]) {
        // 打开登录页面
        LoginViewController *vc = [[LoginViewController alloc] init];
        [Window.rootViewController presentViewController:vc animated:YES completion:nil];
    } else if ([eventName isEqualToString:@"risk"]) {
        // 打开风险测评页面
        RiskViewController *vc = [[RiskViewController alloc] init];
        vc.eventId = id;
        [Window.rootViewController presentViewController:vc animated:YES completion:nil];
    }
}
@end
```

* 事件回调处理

```
// RiskViewController.m
- (void)riskTestFinished {
    // 事件回调，与handleEventWithId:name:params:方法对应
    [JinhuiSDK eventCallbackWithId:self.eventId message:@{@"code": @"0"} data:@{@"rank": @"3"}];
}
```
