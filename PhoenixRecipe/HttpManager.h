//
//  HttpManager.h
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//447693871

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#define RecipePath @"http://jisusrecipe.market.alicloudapi.com/"

@interface HttpManager : NSObject
@property (nonatomic, strong)  AFHTTPSessionManager * _Nonnull sessionManager;



+ (void)getWithPath:(NSString *)path
              param:(NSDictionary *)param
            success:(void (^)(NSURLSessionDataTask *task, id data))success
            failure:(void (^)(void))failure;


+ (void)postWithPath:(NSString *)path
               param:(NSDictionary *)param
        showProgress:(BOOL)isShowProgress
             showMsg:(BOOL)isShowMsg
             success:(void (^)(NSURLSessionDataTask *task, id data))success
             failure:(void (^)(void))failure;




+ (void)getWithPath:(NSString *)path
              param:(NSDictionary *)param
       showProgress:(BOOL)isShowProgress
            showMsg:(BOOL)isShowMsg
            success:(void (^)(NSURLSessionDataTask *task, id data))success
            failure:(void (^)(void))failure;
@end
