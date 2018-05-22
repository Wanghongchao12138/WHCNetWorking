# WHCNetWorking

## 功能
- [x] 基础的GET和POST方法 
- [x] 可添加请求头参数的POST方法
- [x] 可更改返回参数格式的的POST方法
- [x] 图片链接和图片上传 
- [x] 文件的上传和下载（暂时只支持本地数据上传）
- [x] 网络状态监测（例：可用来监测iOS 11出现的使用网络或WIFI提示出现的网络未连接出现的相关问题）

#### 注意：目前，只支持iOS 11以上的版本，保证项目中AFNetWorking版本在3.0以上，GET方法暂时未添加更多操作，如果需要可按照POST添加。

---
![License MIT](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)
![Platform info](https://img.shields.io/cocoapods/p/WMPlayer.svg?style=flat)

## Usage

* 网络监测

   * 第一步 需要在AppDelegate启动的时候添加监测网络的方法

```
  [[WHCNetWorkManager sharedInstance] startMonitoringNetWorking];
  
 *  AFNetworkReachabilityStatus 回调成功的网络状态
    * AFNetworkReachabilityStatusUnknown = -1, //未知的状态
    * AFNetworkReachabilityStatusNotReachable = 0, //不能联网
    * AFNetworkReachabilityStatusReachableViaWWAN = 1, //流量
    * AFNetworkReachabilityStatusReachableViaWiFi = 2, //wifi
 ```  
  * 第二步  可在需要的地方调用如下方法获取当前的网络状态
```
[[WHCNetWorkManager sharedInstance] getNowNetWorkingStatusSuccessBlock:^(AFNetworkReachabilityStatus status) {
    NSLog(@"当前的网络状态是  %ld",status);
 }];
``` 

### 下载工程
本SDK 提供如下列出获取方式:     

#### 1.0 从[github](https://github.com/Wanghongchao12138/WHCNetWorking.git) clone
```
$ git clone https://github.com/Wanghongchao12138/WHCNetWorking.git WHCNetWorking --depth 1
```

#### 2.0 使用Cocoapods 进行安装    

通过Cocoapods 能将本SDK的静态库和代码下载到本地，只需要将类似如下语句中的一句加入你的Podfile：   
```ruby
pod 'WHCNetWorkingTools'
```
执行 pod install即可.  


 

 
 
