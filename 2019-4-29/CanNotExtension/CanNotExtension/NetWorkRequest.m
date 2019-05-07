//
//  NetWorkRequest.m
//  IDFord
//
//  Created by fan on 2018/3/5.
//  Copyright © 2018年 YWJ. All rights reserved.
//

#import "NetWorkRequest.h"
#import "AFHTTPSessionManager.h"

@implementation NetWorkRequest
- (NSURLSessionTask *)postNetWorkRequest:(NSString *)urlString
                        hideAfterGetData:(BOOL)isHide
                                    para:(NSDictionary *)para
                                 success:(SuccessedBlock)success
                                 failure:(FailureBlock)failure{
    NSLog(@"请求URL：%@",urlString);
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 120;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html" ,@"image/jpeg", nil];
    
    
    [manager.requestSerializer setValue:[[self getIdvtoken] objectForKey:@"loginreturnData"] forHTTPHeaderField:@"idvtoken"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionTask *task = [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //传进去的参数以表单的形式组成，遍历字典将
        
        NSArray * allkeys = [para allKeys];
        for (int i = 0; i < para.count; i++) {
            NSString * key = [allkeys objectAtIndex:i];
            id obj  = [para objectForKey:key];
            [formData appendPartWithFormData:[para objectForKey:key] name:key];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        [self saveIdvtoken:task];
        NSDictionary *newJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *flag = [newJson objectForKey:@"result"];
        BOOL successFlag = [flag boolValue];
        if (successFlag){
            success(newJson);
            NSLog(@"请求成功信息：%@", newJson);
        }else{
            failure(newJson);
            NSLog(@"请求错误信息：%@",newJson);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *failDic = [self errorDic:error];
        failure(failDic);
        if ([[failDic allKeys] containsObject:@"returnCode"]) {
            [self codetips:[failDic objectForKey:@"returnCode"]];
        }
    }];
    
    return task;
}

- (NSURLSessionTask *)postNetWorkRequest:(NSString *)urlString
                          needTookenFlag:(BOOL)flag
                                    para:(NSDictionary *)para
                                 success:(SuccessedBlock)success
                                 failure:(FailureBlock)failure{
    NSLog(@"请求URL：%@",urlString);
    
    
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html" ,@"image/jpeg", nil];
    
    if (flag) {
        //token的存取
        [manager.requestSerializer setValue:[[self getIdvtoken] objectForKey:@"loginreturnData"] forHTTPHeaderField:@"idvtoken"];
    }
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionTask *task = [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //传进去的参数以表单的形式组成，遍历字典将
        NSArray * allkeys = [para allKeys];
        for (int i = 0; i < para.count; i++) {
            NSString * key = [allkeys objectAtIndex:i];
            [formData appendPartWithFormData:[para objectForKey:key] name:key];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        [self saveIdvtoken:task];
        
        NSDictionary *newJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *flag = [newJson objectForKey:@"result"];
        BOOL successFlag = [flag boolValue];
        if (successFlag){
            success(newJson);
            NSLog(@"请求成功信息：%@", newJson);
        }else{
            failure(newJson);
            NSLog(@"请求错误信息：%@",newJson);
        }
        

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *failDic = [self errorDic:error];
        failure(failDic);
        if ([[failDic allKeys] containsObject:@"returnCode"]) {
            [self codetips:[failDic objectForKey:@"returnCode"]];
        }
    }];
    
    return task;
}

//JY:noConstruct
- (NSURLSessionTask *)postNetWorkRequestNoConstruct:(NSString *)urlString
                          needTookenFlag:(BOOL)flag
                                    para:(NSDictionary *)para
                                 success:(SuccessedBlock)success
                                 failure:(FailureBlock)failure{
    NSLog(@"请求URL：%@",urlString);
    
    
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html" ,@"image/jpeg", nil];
    
    if (flag) {
        //token的存取
        [manager.requestSerializer setValue:[@{

                                               @"loginreturnData":@"eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyIjp7InRva2VuIjoiZjk1M2ViNmMtMGU5Zi00ZTY4LTgxZTgtMGJkZTA3NzEzMDA2IiwidXNlcm5hbWUiOiJmdGVzdDQiLCJ1c2VySWQiOiJjYjU3NjQxNi1hMzY1LTQ0MzEtOWNlNS05YTczYTM0YzhiNGYiLCJlbWFpbCI6InRlc3RAdGVzdC5jb20iLCJkZWFsZXJJZCI6ImJkOGMxODllLWUyZWEtNDllYS1iZmY0LTFmYmIxMjljZDdiOSIsInJlZ2lvbklkIjoiNTNkNTBjM2QtZDRmZi00OWU0LWE1MTQtNjgyM2QwMDFkZjlkIiwibWFrZU5hbWUiOiJGb3JkIiwibWFrZUlkIjoiNGZkNjFmMWItMjA1My00MGE2LWE0ZWYtMTMxNGVhOWI3ODkwIiwibmVlZENoYW5nZVBhc3N3b3JkIjpmYWxzZSwiZmFjZUxvZ2luT3BlbiI6ZmFsc2V9LCJleHAiOjE1NTY2MTY2Mjd9.CicmI_CTNc9Cd-jQHn9p_t2N4iWqmJwKxlRB3cNcDFDGlSo-hD8qk3-NfmoxkdP2_AllMNEZ8ojPYkUHZo-bGw"
                                               } objectForKey:@"loginreturnData"] forHTTPHeaderField:@"idvtoken"];
    }
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionTask *task = [manager POST:urlString parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        [self saveIdvtoken:task];
        
        NSDictionary *newJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *flag = [newJson objectForKey:@"result"];
        BOOL successFlag = [flag boolValue];
        if (successFlag){
            success(newJson);
            NSLog(@"请求成功信息：%@", newJson);
        }else{
            failure(newJson);
            NSLog(@"请求错误信息：%@",newJson);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *failDic = [self errorDic:error];
        failure(failDic);
        if ([[failDic allKeys] containsObject:@"returnCode"]) {
            [self codetips:[failDic objectForKey:@"returnCode"]];
        }
    }];
    
    return task;
}

//JY:不需要传参的请求
- (NSURLSessionTask *)postNetWorkRequest:(NSString *)urlString
                          needTookenFlag:(BOOL)flag
                                 success:(SuccessedBlock)success
                                 failure:(FailureBlock)failure{
    NSLog(@"请求URL：%@",urlString);
    
    
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 120;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html" ,@"image/jpeg", nil];
    
    if (flag) {
        //token的存取
        [manager.requestSerializer setValue:[[self getIdvtoken] objectForKey:@"loginreturnData"] forHTTPHeaderField:@"idvtoken"];
    }
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionTask *task=[manager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self saveIdvtoken:task];
        
        NSDictionary *newJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *flag = [newJson objectForKey:@"result"];
        BOOL successFlag = [flag boolValue];
        if (successFlag){
            success(newJson);
            NSLog(@"请求成功信息：%@", newJson);
        }else{
            failure(newJson);
            NSLog(@"请求错误信息：%@",newJson);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *failDic = [self errorDic:error];
        failure(failDic);
        if ([[failDic allKeys] containsObject:@"returnCode"]) {
            [self codetips:[failDic objectForKey:@"returnCode"]];
        }
    }];
    
    return task;
}


- (NSURLSessionTask *)uploadImgA:(NSData *)imageA andImgB:(NSData *)imageB para:(NSDictionary *)para
                            success:(SuccessedBlock)success failure:(FailureBlock)failure{
    /////传的图片数据放这里
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html" ,@"image/jpeg", nil];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    [manager.requestSerializer setValue:[[self getIdvtoken] objectForKey:@"loginreturnData"] forHTTPHeaderField:@"idvtoken"];
    
    NSData *base64A = [imageA base64EncodedDataWithOptions:0];
    NSData *base64B = [imageB base64EncodedDataWithOptions:0];
    
    CGFloat lengthA = [imageA length]/1024;
    CGFloat lengthB = [imageB length]/1024;
    
    
    NSURLSessionTask *task = [manager POST:[NSString stringWithFormat:@"%@/application/readIDCardInfo",IDFordDomainName] parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:base64A name:@"photoA"];
        [formData appendPartWithFormData:base64B name:@"photoB"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self saveIdvtoken:task];
        NSDictionary *newJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *flag = [newJson objectForKey:@"result"];
        BOOL successFlag = [flag boolValue];
        if (successFlag){
            success(newJson);
            NSLog(@"请求成功信息：%@", newJson);
        }else{
            failure(newJson);
            NSLog(@"请求错误信息：%@",newJson);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *failDic = [self errorDic:error];
        failure(failDic);
        if ([[failDic allKeys] containsObject:@"returnCode"]) {
            [self codetips:[failDic objectForKey:@"returnCode"]];
        }
    }];
    
    return task;
}
///上传非身份证新方法
- (NSURLSessionTask *)uploadNoIDStep:(NSString *)url
                               param:(NSDictionary *)param
                             success:(SuccessedBlock)success
                             failure:(FailureBlock)failure{
    //设置sessionManager
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html" ,@"image/jpeg", nil];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[[self getIdvtoken] objectForKey:@"loginreturnData"] forHTTPHeaderField:@"idvtoken"];
    
    
    NSURLSessionTask *task = [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //formdata放入字典参数
        NSArray * allkeys = [param allKeys];
        for (int i = 0; i < param.count; i++) {
            NSString * key = [allkeys objectAtIndex:i];
            [formData appendPartWithFormData:[param objectForKey:key] name:key];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //更新idvtoken
        [self saveIdvtoken:task];
        
        NSDictionary *newJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *flag = [newJson objectForKey:@"result"];
        BOOL successFlag = [flag boolValue];
        if (successFlag){
            success(newJson);
            NSLog(@"请求成功信息：%@", newJson);
        }else{
            failure(newJson);
            NSLog(@"请求错误信息：%@",newJson);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *failDic = [self errorDic:error];
        failure(failDic);
        if ([[failDic allKeys] containsObject:@"returnCode"]) {
            [self codetips:[failDic objectForKey:@"returnCode"]];
        }
    }];
    return task;
    
}


///上传非身份证
- (NSURLSessionTask *)uploadOneImage:(NSData *)imageA
                                para:(NSDictionary *)para
                            USERTYPE:(NSInteger)USERTYPE
                             success:(SuccessedBlock)success
                             failure:(FailureBlock)failure{
    
    /////传的图片数据放这里
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html" ,@"image/jpeg", nil];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    //token的存取
    [manager.requestSerializer setValue:[[self getIdvtoken] objectForKey:@"loginreturnData"] forHTTPHeaderField:@"idvtoken"];
    
    NSData *base64A = [imageA base64EncodedDataWithOptions:0];
    NSString *myURL = [[NSString alloc] init];
    if (USERTYPE == 0) {
        //主借人
        myURL = [NSString stringWithFormat:@"%@/application/uploadNonIDCard",IDFordDomainName];
    }else{
        //共借人
        myURL = [NSString stringWithFormat:@"%@/application/uploadCoBorrowNonIDCard",IDFordDomainName];
    }
    NSLog(@"请求URL：%@",myURL);
    NSURLSessionTask *task = [manager POST:myURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:base64A name:@"photoA"];
        
        NSArray * allkeys = [para allKeys];
        for (int i = 0; i < para.count; i++) {
            NSString * key = [allkeys objectAtIndex:i];
            id obj  = [para objectForKey:key];
            NSLog(@"obj %@",obj);
            [formData appendPartWithFormData:[para objectForKey:key] name:key];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self saveIdvtoken:task];
        
        NSDictionary *newJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *flag = [newJson objectForKey:@"result"];
        BOOL successFlag = [flag boolValue];
        if (successFlag){
            success(newJson);
            NSLog(@"请求成功信息：%@", newJson);
        }else{
            failure(newJson);
            NSLog(@"请求错误信息：%@",newJson);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *failDic = [self errorDic:error];
        failure(failDic);
        if ([[failDic allKeys] containsObject:@"returnCode"]) {
            [self codetips:[failDic objectForKey:@"returnCode"]];
        }
    }];
    return task;
}


- (NSURLSessionTask *)postProgressRequest:(NSString *)urlString hideAfterGetData:(BOOL)isHide para:(NSDictionary *)para success:(SuccessedBlock)success failure:(FailureBlock)failure  progress:(ProgressBlock)progress{
    NSLog(@"请求URL：%@",urlString);
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html" ,@"image/jpeg", nil];
    //    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    //token的存取
    [manager.requestSerializer setValue:[[self getIdvtoken] objectForKey:@"loginreturnData"] forHTTPHeaderField:@"idvtoken"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionTask *task = [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //传进去的参数以表单的形式组成，遍历字典将
        NSArray * allkeys = [para allKeys];
        for (int i = 0; i < para.count; i++) {
            NSString * key = [allkeys objectAtIndex:i];
            id obj  = [para objectForKey:key];
            NSLog(@"obj %@",obj);
            
            [formData appendPartWithFormData:[para objectForKey:key] name:key];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        [self saveIdvtoken:task];
        //返回请求成功信息
        NSDictionary *newJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *flag = [newJson objectForKey:@"result"];
        BOOL successFlag = [flag boolValue];
        if (successFlag){
            success(newJson);
            NSLog(@"请求成功信息：%@", newJson);
        }else{
            failure(newJson);
            NSLog(@"请求错误信息：%@",newJson);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *failDic = [self errorDic:error];
        failure(failDic);
        if ([[failDic allKeys] containsObject:@"returnCode"]) {
            [self codetips:[failDic objectForKey:@"returnCode"]];
        }
        
    }];
    
    return task;
}

- (NSDictionary *)errorDic: (NSError *)error{
    NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
    NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSData *myData = [errorStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *failDic = [NSJSONSerialization JSONObjectWithData:myData options:0 error:nil];
    NSMutableDictionary *dic = [NSMutableDictionary new];

    return dic;
}

//根据返回错误信息判断是否弹出登录页面
- (void)codetips: (NSString *) returnCode{

}

//获取顶部视图
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

//更新idvtoken
- (void)saveIdvtoken: (NSURLSessionDataTask *)task{
    NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse*)task.response;
    NSDictionary *dictResponse = httpURLResponse.allHeaderFields;
    
    if ([[dictResponse allKeys] containsObject:@"idvtoken"]) {
        // 解析数据
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *fileName = [path stringByAppendingPathComponent:@"loginreturnData.plist"];
        NSDictionary *tokenDic = @{@"loginreturnData" : [dictResponse objectForKey:@"idvtoken"]};
        BOOL saveState = [tokenDic writeToFile:fileName atomically:YES];
        if (saveState) {
            NSLog(@"重新存储成功");
        }
    }
}
//读取idvtoken
- (NSDictionary *)getIdvtoken{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"loginreturnData.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:fileName];
    
    return dict;
}


- (void)cancelTask:(NSURLSessionTask *)task{
    [task cancel];
}

@end
