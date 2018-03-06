//
//  WHCNetWorkManager.m
//  WHCNetWorking
//
//  Created by 王红超 on 2018/1/23.
//  Copyright © 2018年 WHC. All rights reserved.
//

#import "WHCNetWorkManager.h"
#define kRequestTimeOutTime 5

#define DLog( s, ... ) NSLog( @"< %@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

@implementation WHCNetWorkManager
+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
static AFHTTPSessionManager *manager;
- (AFHTTPSessionManager *)baseHtppRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        AFHTTPRequestSerializer *request_serializer = [AFHTTPRequestSerializer serializer];
        //        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//html
        manager.requestSerializer = request_serializer;
        [manager.requestSerializer setTimeoutInterval:kRequestTimeOutTime];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    });
    return manager;
}

static AFHTTPSessionManager *managerJson;
- (AFHTTPSessionManager *)baseHtppRequestJson
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
        [manager.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];//如果报接受类型不一致请替换一致text/html或别的
        manager.requestSerializer=[AFJSONRequestSerializer serializer];//申明请求的数据是json类型
        managerJson = manager;
    });
    return managerJson;
}


- (AFHTTPSessionManager *)baseHtppRequest:(NSData *)data
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:kRequestTimeOutTime];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)[data length]] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
    return manager;
}
#pragma mark --NetWorking POST--
-(void)postJsonData:(id)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPSessionManager *manager = [self baseHtppRequest];
    //两种编码方式
    NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:urlStr parameters:userInfo progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DebugLog(@"postJson error = %@",error);
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}
- (void)postJsonInfo:(id)userInfo AndEncryptionheader:(NSString *)headerStr url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    // utf-8 编码
    NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
//    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];//申明返回的结果是xml类型
    [manager.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];//可编辑 可更换
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    [manager.requestSerializer setValue:headerStr forHTTPHeaderField:@"accessToken"];
    
    [manager POST:urlStr parameters:userInfo progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        DebugLog(@"postJson error = %@",error);
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}
- (void)postHtmlData:(id)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    //  manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:urlStr parameters:userInfo progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DebugLog(@"postJson error = %@",error);
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}
#pragma mark --NetWorking GET--
- (void)getJsonInfo:(id)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    AFHTTPSessionManager *manager = [self baseHtppRequest];
    [manager GET:url parameters:userInfo progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}
#pragma mark --图片上传 字典格式--
- (void)PostImgWithDic:(id)userInfo withImg:(NSDictionary *)imgDic url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    AFHTTPSessionManager *postAvatarManager = [AFHTTPSessionManager manager];
    postAvatarManager.responseSerializer= [AFHTTPResponseSerializer serializer];
    [postAvatarManager POST:url parameters:userInfo constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imgDic.allKeys.count == 0) {
            NSLog(@"没有图片上传");
        }else
        {
            for (id key in imgDic) {
                UIImage *image = [imgDic objectForKey:key];
                NSData *data = [[NSData alloc] init];
                data = UIImageJPEGRepresentation(image, 1.0);
                CGFloat count = 100;
                DLog(@"图片大小%ld",data.length);
                while (data.length > 300000) {//300k
                    count--;
                    data =  UIImageJPEGRepresentation(image, count / 100);
                    DLog(@"变化图片大小%ld,%f",data.length,count / 100);
                }
                [formData appendPartWithFileData: data name:[NSString stringWithFormat:@"%@",key] fileName:[NSString stringWithFormat:@"%@.jpeg",key] mimeType:@"image/jpeg"];//Type:@"image/jpeg"fileName:[NSString stringWithFormat:@"%@.png"
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"上传图片成功了AFN ");
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        //        NSLog(@"上传图片失败了了AFN ");
        DLog(@"上传图片失败了了AFN ");
        failureBlock(errorStr);
    }];
}
#pragma mark --监测网络状态--
static AFNetworkReachabilityManager *managerNetWorkStatus;
- (AFNetworkReachabilityManager *)baseHtppRequestNetWorkStatus
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managerNetWorkStatus = [AFNetworkReachabilityManager manager];
    });
    return managerNetWorkStatus;
}
-(void)startMonitoringNetWorking{
    AFNetworkReachabilityManager *managerNetWorkStatus = [self baseHtppRequestNetWorkStatus];
    [managerNetWorkStatus startMonitoring];
}
-(void)getNowNetWorkingStatusSuccessBlock:(void (^)(AFNetworkReachabilityStatus status))successBlock {
    AFNetworkReachabilityManager *managerNetWorkStatus = [self baseHtppRequestNetWorkStatus];
    [managerNetWorkStatus setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus statu) {
        DLog(@"%ld", statu);
        successBlock(statu);
    }];

}

#pragma mark --文件的上传和下载 --
- (void)PostFileWithDic:(id)userInfo url:(NSString *)url AndFilePaht:(NSString *)filePath AndFileName:(NSString *)fileName sucProgress:(void (^)(CGFloat progress))proBlock successBlock:(SuccessBlock)successBlock failureBlock:(void(^)(NSError *error))failureBlock
{
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [self baseHtppRequest];

    [manager POST:url parameters:userInfo constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        [formData appendPartWithFileURL:fileUrl name:fileName error:nil];
        //第二种拼接方法：简写方法
        //[formData appendPartWithFileURL:fileUrl name:@"file" fileName:@"1234.png" mimeType:@"image/png" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        uploadProgress.completedUnitCount:已经上传的数据大小
//        
//        uploadProgress.totalUnitCount：数据的总大小
        CGFloat prog = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        DLog(@"%f",prog);
        proBlock(prog);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"请求成功----%@",responseObject);
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        DLog(@"请求失败----%@",error);
        failureBlock(error);
    }];
}
                

- (void)DownFileWithUrl:(NSString *)url sucProgress:(void (^)(CGFloat progress))proBlock FullPath:(void(^)(NSURL *fullPath))pathBlock sucEndLocalHostFilePath:(void(^)(NSURL *localHostFilePath))localHostFilePathBlock failureBlock:(void(^)(NSError *error))failureBlock
{
    AFHTTPSessionManager *manager = [self baseHtppRequest];
    
//    2.1 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
 
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //监听下载进度
        //completedUnitCount 已经下载的数据大小
        //totalUnitCount     文件数据的中大小
        CGFloat prog = 1.0 *downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        DLog(@"%f",prog);
        proBlock(prog);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        /**
         * 1:1：请求路径：NSUrl *url = [NSUrl urlWithString:path];从网络请求路径  2：把本地的file文件路径转成url，NSUrl *url = [NSURL fileURLWithPath:fullPath]；
         2：返回值是一个下载文件的路径
         *
         */
        NSString *fullPathStr = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        
        DLog(@"targetPath:%@",targetPath);
        DLog(@"fullPath:%@",fullPathStr);
        NSURL *fullP = [NSURL fileURLWithPath:fullPathStr];
        pathBlock(fullP);
        return fullP;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        /**
         *filePath:下载后文件的保存路径
         */
        if (error) {
            DLog(@"down error %@",error);
            failureBlock(error);
        }else{
            DLog(@"down success %@",filePath);
            localHostFilePathBlock(filePath);
        }
    }];
    
    //3.执行Task
    [download resume];
}
@end
