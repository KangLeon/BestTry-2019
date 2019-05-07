//
//  NetWorkRequest.h
//  IDFord
//
//  Created by fan on 2018/3/5.
//  Copyright © 2018年 YWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessedBlock)(id successDic);
typedef void(^FailureBlock)(id failureDic);
typedef void(^ProgressBlock)(NSProgress *progress);
@interface NetWorkRequest : NSObject
@property (nonatomic, copy) SuccessedBlock successBlock;
@property (nonatomic, copy) FailureBlock failureBlock;
@property (nonatomic, copy) ProgressBlock progressBlock;

/**
 post请求(持续5秒)
 
 @param urlString <#urlString description#>
 @param para <#para description#>
 @param success <#success description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (NSURLSessionTask *)postNetWorkRequest:(NSString *)urlString hideAfterGetData:(BOOL)isHide para:(NSDictionary *)para success:(SuccessedBlock)success failure:(FailureBlock)failure;
//是否需要token
- (NSURLSessionTask *)postNetWorkRequest:(NSString *)urlString needTookenFlag:(BOOL)flag para:(NSDictionary *)para success:(SuccessedBlock)success failure:(FailureBlock)failure;
//不需要传参
- (NSURLSessionTask *)postNetWorkRequest:(NSString *)urlString
                          needTookenFlag:(BOOL)flag
                                 success:(SuccessedBlock)success
                                 failure:(FailureBlock)failure;
//不用把参数转成utf-8形式
- (NSURLSessionTask *)postNetWorkRequestNoConstruct:(NSString *)urlString
                                     needTookenFlag:(BOOL)flag
                                               para:(NSDictionary *)para
                                            success:(SuccessedBlock)success
                                            failure:(FailureBlock)failure;


/**
 get请求(持续5秒)
 
 @param urlString <#urlString description#>
 @param para <#para description#>
 @param success <#success description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
//- (NSURLSessionTask *)getNetWorkRequest:(NSString *)urlString hideAfterGetData:(BOOL)isHide para:(NSDictionary *)para success:(SuccessedBlock)success failure:(FailureBlock)failure;


/**
 上传照片

 @param imageA <#imageA description#>
 @param imageB <#imageB description#>
 @param para <#para description#>
 @param success <#success description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (NSURLSessionTask *)uploadImgA:(NSData *)imageA andImgB:(NSData *)imageB para:(NSDictionary *)para success:(SuccessedBlock)success failure:(FailureBlock)failure;

- (NSURLSessionTask *)uploadOneImage:(NSData *)imageA para:(NSDictionary *)para USERTYPE:(NSInteger)USERTYPE
                             success:(SuccessedBlock)success failure:(FailureBlock)failure;

/**
 post请求(带进度条)
 
 @param urlString <#urlString description#>
 @param para <#para description#>
 @param success <#success description#>
 @param failure <#failure description#>
 @param progress
 @return <#return value description#>
 */
- (NSURLSessionTask *)postProgressRequest:(NSString *)urlString hideAfterGetData:(BOOL)isHide para:(NSDictionary *)para success:(SuccessedBlock)success failure:(FailureBlock)failure progress:(ProgressBlock)progress;

/**
 none ID第一步
 */
- (NSURLSessionTask *)uploadNoIDStep:(NSString *)url
                               param:(NSDictionary *)param
                             success:(SuccessedBlock)success
                             failure:(FailureBlock)failure;


- (void)cancelTask:(NSURLSessionTask *)task;
- (NSDictionary *)getIdvtoken;
@end
