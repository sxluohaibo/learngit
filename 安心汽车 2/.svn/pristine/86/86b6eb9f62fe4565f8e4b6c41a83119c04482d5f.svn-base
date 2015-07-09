//
//  HALoginUserInfo.h
//  安心汽车
//
//  Created by un2lock on 15/4/16.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HABaseAnxin.h"
@class HAUserResult;
@class HAUserParam;
@interface HABeanLoginUserInfo : HABaseAnxin

+ (HABeanLoginUserInfo *)shareLoginUserInfo;
/**
 *  用户信息
 *
 *  @param result 判断是否登录
 *  @param param  存放着用户的信息
 */
- (void)addLoginUserInfoData:(HAUserResult *)result param:(HAUserParam *) param userNo:(NSString *) userNo;
/**
 *  删除数据库
 */
- (void)removeDB;
/**
 获取用户编号
 */
- (NSString *)getuserNo:(NSString *) userAccount;

@end
