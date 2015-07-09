//
//  HA4SInfoTool.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/27.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  4s店咨询数据请求

#import "HA4SInfoTool.h"
#import "HA4SInfoRequestParame.h"
#import "HA4SRequestResult.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "HADetailResult.h"
#import "MJExtension.h"


@implementation HA4SInfoTool


/**
 *  加载网络数据
 *
 *  @param parame  参数
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)store4SMessage:(HA4SInfoRequestParame *)parame success:(void(^)(NSArray *))success failure:(void(^)(NSError*))failure{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://file.ywsoftware.com:9090/T100040/news/showNewsInfoList" parameters:[parame keyValues] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"xxxxxxxxx");
            NSArray * resultArray  = [HA4SRequestResult objectArrayWithKeyValuesArray:responseObject[@"newsList"]];
            success(resultArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
    }];
}


/**
 *  加载网络数据
 *
 */
+ (void)store4SDetailMessage:(NSInteger)parame success:(void(^)(HADetailResult *))success failure:(void(^)(NSError*))failure{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary * parame1 = [NSMutableDictionary dictionary];
    parame1[@"newsId"] = @(parame);
    [manager POST:@"http://file.ywsoftware.com:9090/T100040/news/showNewsDetail" parameters:parame1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        HADetailResult * result = [HADetailResult objectWithKeyValues:responseObject[@"news"]];
        success(result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
    }];
    
}
@end
