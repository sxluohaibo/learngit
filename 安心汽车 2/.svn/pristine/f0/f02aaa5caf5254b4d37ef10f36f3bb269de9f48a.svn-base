//
//  HANetTool.m
//  安心汽车
//
//  Created by un2lock on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HANetTool.h"

@interface HANetTool()
@property(nonatomic,strong) AFHTTPRequestOperationManager *mrg;
@end

@implementation HANetTool
HASingletonM(NetTool)

-(AFHTTPRequestOperationManager *)mrg{
    if(_mrg==nil){
        self.mrg=[[AFHTTPRequestOperationManager alloc] init];
        _mrg.responseSerializer=[AFHTTPResponseSerializer serializer];
    }
    return _mrg;
}
- (void)request:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    NSLog(@"url == %@",url);
    if(_mrg==nil){
        self.mrg=[[AFHTTPRequestOperationManager alloc] init];
        _mrg.responseSerializer=[AFHTTPResponseSerializer serializer];
    }
    [_mrg GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
@end
