//
//  HAUserTool.m
//  安心汽车
//
//  Created by un2lock on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAUserTool.h"
#import "HAUserParam.h"
#import "HAUserResult.h"
#import "HACarResult.h"
#import "MJExtension.h"

@implementation HAUserTool
+ (void)login:(HAUserParam *)param success:(void (^)(HAUserResult *result))success failure:(void (^)(NSError *error))failure{
    HANetTool *tool=[HANetTool sharedNetTool];
    NSString *URL = [HTTP_MAIN_URL stringByAppendingFormat:@"%@",@"/T100040/login/login"];
    [tool request:URL params:param.keyValues success:^(id json) {
        //NSLog(@"json == %@",[json objectFromJSONData]);
        HAUserResult *obj = [HAUserResult objectWithJSONData:json];
        success(obj);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//登陆返回车辆的信息
+ (void)carInfo:(HAUserParam *)param success:(void (^)(HACarInfoResult *result))success failure:(void (^)(NSError *error))failure{
    HANetTool *tool=[HANetTool sharedNetTool];
    //@"http://file.ywsoftware.com:9090/T100040/appointment/showCarInfo?phoneNo=13185977410"
    NSString *tempString = [NSString stringWithFormat:@"/T100040/appointment/showCarInfo?phoneNo=%@",[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserPhonenumer]];
    NSString *URL = [HTTP_MAIN_URL stringByAppendingFormat:@"%@",tempString];
    [tool request:URL params:nil success:^(id json) {
        //NSLog(@"json111 == %@",[json objectFromJSONData]);
        HACarInfoResult *obj = [HAManger parseCarResult:[json objectFromJSONData]];
        success(obj);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 *  用户注册
 */
+ (void)registe:(HAUserParam *)param success:(void (^)(HAUserResult *result))success failure:(void (^)(NSError *error))failure{
    HANetTool *tool=[HANetTool sharedNetTool];
    //@"http://file.ywsoftware.com:9090/T100040/register/regist"
    NSString *URL = [HTTP_MAIN_URL stringByAppendingFormat:@"%@",@"/T100040/register/regist"];
    [tool request:URL params:param.keyValues success:^(id json) {
        HAUserResult *obj = [HAUserResult objectWithJSONData:json];
        success(obj);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 获取验证码
 */
+ (void)getcaptcha:(HAUserParam *)param success:(void (^)(HAUserResult *result))success failure:(void (^)(NSError *error))failure{
    HANetTool *tool=[HANetTool sharedNetTool];
    //@"http://file.ywsoftware.com:9090/T100040/register/sendCode"
    NSString *URL = [HTTP_MAIN_URL stringByAppendingFormat:@"%@",@"/T100040/register/sendCode"];
    [tool request:URL params:param.keyValues success:^(id json) {
        HAUserResult *obj = [HAUserResult objectWithJSONData:json];
        success(obj);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 验证老密码
 */
+ (void)checkOldPwd:(HAUserParam *)param success:(void (^)(HAUserResult *result))success failure:(void (^)(NSError *error))failure{
    HANetTool *tool=[HANetTool sharedNetTool];
    //@"http://file.ywsoftware.com:9090/T100040/login/checkPwd"
    NSString *URL = [HTTP_MAIN_URL stringByAppendingFormat:@"%@",@"/T100040/login/checkPwd"];
    [tool request:URL params:param.keyValues success:^(id json) {
        HAUserResult *obj = [HAUserResult objectWithJSONData:json];
        success(obj);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 修改密码
 */
+ (void)changePwd:(HAUserParam *)param success:(void (^)(HAUserResult *result))success failure:(void (^)(NSError *error))failure{
    HANetTool *tool=[HANetTool sharedNetTool];
    //@"http://file.ywsoftware.com:9090/T100040/login/changePwd"
    NSString *URL = [HTTP_MAIN_URL stringByAppendingFormat:@"%@",@"/T100040/login/changePwd"];
    [tool request:URL params:param.keyValues success:^(id json) {
        HAUserResult *obj = [HAUserResult objectWithJSONData:json];
        success(obj);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 *  获取手机号对应的车辆信息
 */
+ (void)getCarInfo:(HAUserParam *)param success:(void (^)(HACarResult *result))success failure:(void (^)(NSError *error))failure{
    HANetTool *tool=[HANetTool sharedNetTool];
    //@"http://file.ywsoftware.com:9090/T100040/login/changePwd"
    NSString *URL = [HTTP_MAIN_URL stringByAppendingFormat:@"%@",@"/T100040/appointment/showCarInfo"];
    [tool request:URL params:param.keyValues success:^(id json) {
        HACarResult *obj = [HACarResult objectWithJSONData:json];
        success(obj);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
