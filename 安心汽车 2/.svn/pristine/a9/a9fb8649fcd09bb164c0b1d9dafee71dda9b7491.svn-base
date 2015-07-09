//
//  HALoginUserInfo.m
//  安心汽车
//
//  Created by un2lock on 15/4/16.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HABeanLoginUserInfo.h"
#import "HAUserResult.h"
#import "HAUserParam.h"
static HABeanLoginUserInfo *shareLoginInfo = nil;
@implementation HABeanLoginUserInfo

//单列
+ (HABeanLoginUserInfo *)shareLoginUserInfo{
    if (!shareLoginInfo) {
        shareLoginInfo = [[HABeanLoginUserInfo alloc] init];
    }
    return shareLoginInfo;
}
/**
 *  用户信息
 *
 *  @param result 判断是否登录
 *  @param param  存放着用户的信息
 */
- (void)addLoginUserInfoData:(HAUserResult *)result param:(HAUserParam *) param userNo:(NSString *) userNo{
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO %@ (userNo,userName,userPassWord) VALUES ('%@','%@','%@')",LoginUser_DB ,userNo,param.userAccount,param.password];
    LOG(@"sql %@",sql);
    if([self openDatabase]){
        [db beginTransaction];
        [db executeUpdate:sql];
        if ([db hadError]) {
            NSLog(@"Err %d:%@", [db lastErrorCode], [db lastErrorMessage]);
        }else{
            NSLog(@"当前数据-----插入成功!");
        }
        [db commit];
        [self closeDatabase];
    }
}
/**
 *  删除数据
 */
- (void)removeDB{
    NSString * sql = [NSString stringWithFormat:@"drop table %@",LoginUser_DB];
    if([self openDatabase]){
        [db beginTransaction];
        [db executeUpdate:sql];
        if ([db hadError]) {
            LOG(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }else{
            NSLog(@"删除成功!");
        }
        [db commit];
        [self closeDatabase];
    }
}
/**
 获取用户编号
 */
- (NSString *)getuserNo:(NSString *)userAccount{
    NSString * sql = [NSString stringWithFormat:@"select userNo FROM %@ WHERE userAccount=%@",LoginUser_DB,userAccount];
    if([self openDatabase]){
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *result=[rs stringForColumn:@"userNo"];
            return result;
        }
        [rs close];
        [self closeDatabase];
    }
    return @"";
}
@end
