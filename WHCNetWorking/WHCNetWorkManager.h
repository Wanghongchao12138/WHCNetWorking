//
//  WHCNetWorkManager.h
//  WHCNetWorking
//
//  Created by 王红超 on 2018/1/23.
//  Copyright © 2018年 WHC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

/// 成功回调
typedef void(^SuccessBlock)(id responseBody);
///失败回调
typedef void(^FailureBlock)(NSString *error);

@interface WHCNetWorkManager : NSObject
+ (instancetype)sharedInstance;
-(AFHTTPSessionManager *)baseHtppRequest;
-(AFHTTPSessionManager *)baseHtppRequest:(NSData *)data;
#pragma mark --post
/**
 *  请求方式      POST
 *  @userInfo   请求参数  返回参数Json格式
 *  @url        接口地址
 *  @param successBlock 接口请求成功回调
 *  @param failureBlock 接口请求失败回调
 */
-(void)postJsonData:(id)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

/**
 *  请求方式      POST
 *  @userInfo   请求参数 返回参数Json格式（返回数据格式可手动调试）
 *  @headerStr  接口请求头参数（可手动添加或删除）
 *  @url        接口地址
 *  @param successBlock 接口请求成功回调
 *  @param failureBlock 接口请求失败回调
 */
- (void)postJsonInfo:(id)userInfo AndEncryptionheader:(NSString *)headerStr url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

/**
 *  请求方式      POST
 *  @userInfo   请求参数 返回参数HTML格式
 *  @url        接口地址
 *  @param successBlock 接口请求成功回调
 *  @param failureBlock 接口请求失败回调
 */
- (void)postHtmlData:(id)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark --get
/**
 *  请求方式      GET
 *  @userInfo   请求参数  返回参数Json格式
 *  @url        接口地址
 *  @param successBlock 接口请求成功回调
 *  @param failureBlock 接口请求失败回调
 */
- (void)getJsonInfo:(id)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

/**
 *  GET方法添加请求头参数可参考post添加对应的方法
 */

#pragma mark --图片上传--
/**
 *  请求方式      POST
 *  @userInfo   请求参数  返回参数Json格式
 *  @url        接口地址
 *  @imgDic     上传图片字典
 *  @param successBlock 接口请求成功回调
 *  @param failureBlock 接口请求失败回调
 */
- (void)PostImgWithDic:(id)userInfo withImg:(NSDictionary *)imgDic url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark --文件的上传和下载--
/**
 *  本地路径文件上传
 *  @userInfo           文件上传的参数名称 字典格式
 *  @url                文件上传接口地址
 *  @filePath           文件上传本地路径
 *  @fileName           文件参数对应的参数名称
 *  @param proBlock     文件上传进度回调
 *  @param successBlock    文件上传地址回调
 *  @param failureBlock    文件上传失败回调 错误信息
 */
- (void)PostFileWithDic:(id)userInfo url:(NSString *)url AndFilePaht:(NSString *)filePath AndFileName:(NSString *)fileName sucProgress:(void (^)(CGFloat progress))proBlock successBlock:(SuccessBlock)successBlock failureBlock:(void(^)(NSError *error))failureBlock;

/**
 *  @url        文件下载接口地址
 *  @param proBlock     文件下载进度回调
 *  @param pathBlock    文件下载地址回调
 *  @param localHostFilePathBlock    文件下载成功存储本地地址回调
 *  @param failureBlock    文件下载失败回调 错误信息
 */
- (void)DownFileWithUrl:(NSString *)url sucProgress:(void (^)(CGFloat progress))proBlock FullPath:(void(^)(NSURL *fullPath))pathBlock sucEndLocalHostFilePath:(void(^)(NSURL *localHostFilePath))localHostFilePathBlock failureBlock:(void(^)(NSError *error))failureBlock;
#pragma mark --监测网络状态--
/**
 *  在项目开始的时候就调用这个方法 开始监测网络状态
 */
-(void)startMonitoringNetWorking;

/**
 *  获取当前的网络状态
 *  @param successBlock 接口请求成功回调
 *  AFNetworkReachabilityStatus 回调成功的网络状态
    * AFNetworkReachabilityStatusUnknown = -1, //未知的状态
    * AFNetworkReachabilityStatusNotReachable = 0, //不能联网
    * AFNetworkReachabilityStatusReachableViaWWAN = 1, //流量
    * AFNetworkReachabilityStatusReachableViaWiFi = 2, //wifi
 */
-(void)getNowNetWorkingStatusSuccessBlock:(void (^)(AFNetworkReachabilityStatus status))successBlock;
@end
