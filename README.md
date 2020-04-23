# 金汇金融业务SDK集成文档 v1.1.0
* 文档维护人：邱敏舜

## 一、集成环境
* iOS 9+

## 二、运行Demo
执行`pod install`，即可正常运行Demo App。

## 三、集成示例及API说明

#### 注意事项
代码仓库中包含大文件，必要时请参考：
[Duplicating a repository with Git Large File Storage objects](https://help.github.com/en/articles/duplicating-a-repository/#mirroring-a-repository-that-contains-git-large-file-storage-objects)

#### 手动集成JinhuiSDK.framework
* 将源码目录下的`JinhuiSDK.framework`、`libmp3lame.a`及子目录`MGFaceID`、`FaceSDK`添加到项目中
* 工程设置的`Linked Frameworks and Libraries`中添加以下项
```
JinhuiSDK.framework
libmp3lame.a
AVFoundation.framework
CoreMedia.framework
CoreMotion.framework
SystemConfiguration.framework
WebKit.framework
```
* 确保工程中存在至少一个.mm文件，如果没有，可将任意一个.m文件改成.mm

#### Info.plist中添加所需权限
```
    <key>NSCameraUsageDescription</key>
	<string>需要使用相机拍照进行实名认证、银行卡识别</string>
	<key>NSMicrophoneUsageDescription</key>
	<string>需要使用麦克风录音完成合格投资者承诺</string>
	<key>NSPhotoLibraryAddUsageDescription</key>
	<string>需要保存身份证、银行卡照片到相册</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>需要读取相册中的身份证照片进行实名认证</string>
```

#### 测试模式下，允许加载http请求
```
    // 在Info.plist添加如下配置
    <key>NSAppTransportSecurity</key>
    <dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    </dict>
```

#### 初始化
```
// AppDelegate.m
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
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
    
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return [UIViewController orientationMask];
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
部分页面路由地址

|页面|参数|扩展参数|备注|
|:-:|:-:|:-:|:-:|
|活期理财|/channel/product/huoqi |无||
|稳健理财|/channel/product/wenjian|无||
|资管私募|/channel/product/ziguansimu|无||
|公募基金|/product/mutual|无||
|股交产品|/channel/product/gujiao|无||


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

#### 退出登录
```
// 用户退出登录，应调用SDK方法退出登录
[JinhuiSDK logout];
```
#### 事件监听及回调

* 事件监听处理（事件处理完成应调用SDK提供的回调方法）

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

* 事件回调处理（事件处理完成后应当以事件触发时的eventId进行回调）

```
// RiskViewController.m
- (void)riskTestFinished {
    // 事件回调，与handleEventWithId:name:params:方法对应，回调的eventId与事件触发时的eventId一致。
    [JinhuiSDK eventCallbackWithId:self.eventId message:@{@"code": @"0", @"message": @"风险测评完成"} data:@{@"rank": @"3"}];
}
```

## 四、API参数字段说明
* 登录所用的用户信息最小集及其含义如下
```
name : 用户名
mobile : 手机号
idNo : 身份证号
bankAccount : 华创资金账号
```

* 目前需要处理的事件type如下
```
login : App用户登录，登录完成后应调用[JinhuiSDK login:]登录SDK
risk : 风险等级测评
```

* 事件回调message字段含义如下
```
code : 状态码，0表示成功，其他表示失败
message : 事件消息
```



# 变更历史

### 1.1.0   增加人脸检测  

### 1.0.2   修复@available() 导致不兼容Xcode 11以下版本的问题

### 1.0.0   删除UIWebView引用

### 0.1.18  添加活体识别功能

### 0.1.13  bugfix:iOS 13上获取状态栏问题，改用判断刘海屏实现

### 0.1.12  bugfix:iOS 13上获取状态栏问题，UIWindowScene实现

### 0.1.11  bugfix:导航栏隐藏控制

### 0.1.10  bugfix:导航栏隐藏顺序控制：宿主控制优先

### 0.1.9   bugfix:取消页面刷新

### 0.1.8   信托录像功能

### 0.1.7   横竖屏支持

### 0.1.6   协议公告pdf在新实例中打开，显示导航栏，如果隐藏导航栏可能无法返回上一页

### 0.1.5   bugfix：KVO未在被监听对象dealloc前remove掉导致崩溃的问题

### 0.1.4   cookie删除时，value统一为空

### 0.1.3   导航栏和状态栏处理

### 0.1.2   WKWebView版本

### 0.1.1   UIWebView版本

### 0.1.0   初版
