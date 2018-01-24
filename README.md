# WHCNetWorking

基于AFNetWorking 的tools
只是有一些简单的功能使用
- 1.基础的GET和POST方法 
- 2.可添加请求头参数的POST方法 
- 3.可更改返回参数格式的的POST方法 
- 4.图片链接和图片上传 
- 5.文件的上传和下载（暂时只支持本地数据上传） 
- 6.网络状态监测（例：可用来监测iOS 11出现的使用网络或WIFI提示出现的网络未连接出现的相关问题）

网络监测

  第一步 需要在AppDelegate启动的时候添加监测网络的方法
  [[WHCNetWorkManager sharedInstance] startMonitoringNetWorking];
  
 *  AFNetworkReachabilityStatus 回调成功的网络状态
    * AFNetworkReachabilityStatusUnknown = -1, //未知的状态
    * AFNetworkReachabilityStatusNotReachable = 0, //不能联网
    * AFNetworkReachabilityStatusReachableViaWWAN = 1, //流量
    * AFNetworkReachabilityStatusReachableViaWiFi = 2, //wifi
    
第二步  可在需要的地方调用如下方法获取当前的网络状态
[[WHCNetWorkManager sharedInstance] getNowNetWorkingStatusSuccessBlock:^(AFNetworkReachabilityStatus status) {
    NSLog(@"当前的网络状态是  %ld",status);
 }];
 
注意：目前，只支持iOS 11以上的版本，保证项目中AFNetWorking版本在3.0以上，GET方法暂时未添加更多操作，如果需要可按照POST添加。
