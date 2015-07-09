//
//  HANetTool.h
//  安心汽车
//
//  Created by un2lock on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HASingleton.h"
@interface HANetTool : NSObject
HASingletonH(NetTool)
- (void)request:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
