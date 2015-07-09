//
//  HAUserParam.h
//  安心汽车
//
//  Created by un2lock on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAUserParam : NSObject
/**用户名*/
@property(nonatomic,copy) NSString *userAccount;
/**用户呢称*/
@property(nonatomic,copy) NSString *userName;
/**用户密码*/
@property(nonatomic,copy) NSString *password;
/**用户验证码*/
@property(nonatomic,copy) NSString *phoneCode;
/**手机号*/
@property(nonatomic,copy) NSString *phoneNo;
@property(nonatomic,copy) NSString *userNo;
@end
