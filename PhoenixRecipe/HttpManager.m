
//
//  HttpManager.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//
//#define ROOT_PATH @"http://apicloud.mob.com/v1/cook/"
#define ROOT_PATH @""
//@"http://jisusrecipe.market.alicloudapi.com/"
//#define ROOT_PATH @"http://39.108.118.115:7200/"
//#define ROOT_PATH @""
#import "HttpManager.h"
#import "WSProgressHUD.h"
@implementation HttpManager
+ (instancetype)sharedManager{
    static HttpManager *sharedManager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedManager = [[HttpManager alloc]init];
        
        sharedManager.sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:ROOT_PATH]];
        sharedManager.sessionManager.requestSerializer.timeoutInterval = 10;
        sharedManager.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        sharedManager.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        sharedManager.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
        [sharedManager.sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"ios%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"User-Agent"];
        
        
        [sharedManager.sessionManager.requestSerializer setValue:@"APPCODE ebcf9d7568ad4fa68b49bccca495bde6" forHTTPHeaderField:@"Authorization"];
    });
    return sharedManager;
}


+ (void)getWithPath:(NSString *)path
              param:(NSDictionary *)param
       showProgress:(BOOL)isShowProgress
            showMsg:(BOOL)isShowMsg
            success:(void (^)(NSURLSessionDataTask *task, id data))success
            failure:(void (^)(void))failure{
//    path = [NSString stringWithFormat:@"%@%@.action",ROOT_PATH,path];
    if(isShowProgress)[WSProgressHUD show];
    [[HttpManager sharedManager].sessionManager GET:path parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [WSProgressHUD dismiss];
        
        
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSNumber *errorNumber = @([rootDict[@"status"] integerValue]);
        
        if(isShowMsg){
            [WSProgressHUD showErrorWithStatus:rootDict[@"msg"]];
        }else{
            if(isShowProgress){
                [WSProgressHUD dismiss];
            }
        }
        if([errorNumber isEqualToNumber:@0]){//正常
            if(success)
                success(task, rootDict[@"result"]);
        }else{//失败
            if(failure)
                failure();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(isShowMsg){
            [WSProgressHUD showErrorWithStatus:@"网络连接失败"];
        }else{
            if(isShowProgress){
                [WSProgressHUD dismiss];
            }
        }
        if(failure)
            failure();
    }];
    
}

+ (void)postWithPath:(NSString *)path
               param:(NSDictionary *)param
        showProgress:(BOOL)isShowProgress
             showMsg:(BOOL)isShowMsg
             success:(void (^)(NSURLSessionDataTask *task, id data))success
             failure:(void (^)(void))failure{
//    path = [NSString stringWithFormat:@"%@%@.action",ROOT_PATH,path];
    if(isShowMsg)[WSProgressHUD show];
    [[HttpManager sharedManager].sessionManager POST:path parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",param);
        
        [WSProgressHUD dismiss];
        
        
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSNumber *errorNumber = @([rootDict[@"status"] integerValue]);
        
        if(isShowMsg){
            [WSProgressHUD showErrorWithStatus:rootDict[@"msg"]];
        }
        
        if([errorNumber isEqualToNumber:@0]){//正常
            if(success)
                success(task, rootDict[@"result"]);
        }else{//失败
            if(failure)
                failure();
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [WSProgressHUD dismiss];
        if(failure)
            failure();
    }];
}



+ (void)getWithPath:(NSString *)path
              param:(NSDictionary *)param
            success:(void (^)(NSURLSessionDataTask *task, id data))success
            failure:(void (^)(void))failure{
    //    path = [NSString stringWithFormat:@"%@%@.action",ROOT_PATH,path];
    [[HttpManager sharedManager].sessionManager GET:path parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [WSProgressHUD dismiss];
        
        
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if(success)
            success(task, rootDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure)
            failure();
    }];
//        "com.alamofire.serialization.response.error.response" = "<NSHTTPURLResponse: 0x1c0425e60>
//    { URL: http://www.sqdao4.xyz/app_manage/appstate?bundle_id=mini.PhoenixRecipe&name=%E5%87%A4%E5%87%B0 }
//    { Status Code: 500, Headers {
//        \n    Connection =     (\n        close\n    );\n
//        \"Content-Length\" =     (\n        195213\n    );\n
//        \"Content-Type\" =     (\n        \"text/html; charset=UTF-8\"\n    );\n
//        Date =     (\n        \"Mon, 04 Dec 2017 12:48:05 GMT\"\n    );\n
//        Server =     (\n        \"Apache/2.4.6 (CentOS) mod_wsgi/4.5.22 Python/3.6\"\n    );\n
//        Vary =     (\n        Cookie\n    );\n
//    \"X-Frame-Options\" =     (\n        SAMEORIGIN\n    );\n} }";
}


@end
