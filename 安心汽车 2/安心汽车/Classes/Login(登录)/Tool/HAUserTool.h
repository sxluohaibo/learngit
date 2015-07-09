//
//  HAUserTool.h
//  安心汽车
//
//  Created by un2lock on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HANetTool.h"
@class HAUserParam;
@class HAUserResult;
@class HACarResult;
@interface HAUserTool : NSObject

+ (void)carInfo:(HAUserParam *)param success:(void (^)(HACarInfoResult *result))success failure:(void (^)(NSError *error))failure;
/**
 *  用户登录
 */
+ (void)login:(HAUserParam *)param success:(void (^)(HAUserResult *result))success failure:(void (^)(NSError *error))failure;
/**
 *  用户注册
 */
+ (void)registe:(HAUserParam *)param success:(void (^)(HAUserResult *result))success failure:(void (^)(NSError *error))failure;
/**
 *  用户获取验证码
 */
+ (void)getcaptcha:(HAUserParam *)param success:(void (^)(HAUserResult *result))success failure:(void (^)(NSError *error))failure;
/**
 *  修改密码
 */
+ (void)changePwd:(HAUserParam *)param success:(void (^)(HAUserResult *result))success failure:(void (^)(NSError *error))failure;
/**
 *  修改密码
 */
+ (void)checkOldPwd:(HAUserParam *)param success:(void (^)(HAUserResult *result))success failure:(void (^)(NSError *error))failure;
/**
 *  获取手机号对应的车辆信息
 */
+ (void)getCarInfo:(HAUserParam *)param success:(void (^)(HACarResult *result))success failure:(void (^)(NSError *error))failure;
@end
