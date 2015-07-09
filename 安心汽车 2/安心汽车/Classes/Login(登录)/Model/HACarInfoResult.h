//
//  HACarInfoResult.h
//  安心汽车
//
//  Created by kongw on 15/4/21.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HACarResult.h"

@interface HACarInfoResult : NSObject
/**登录标识 例如:success*/
@property(nonatomic,copy) NSString *result;
/**登录标识 例如:0:失败  1:成功*/
@property(nonatomic,copy) NSNumber *resultCode;
/**用户信息的模型*/
@property(nonatomic,strong) HACarResult *carResult;
@end
