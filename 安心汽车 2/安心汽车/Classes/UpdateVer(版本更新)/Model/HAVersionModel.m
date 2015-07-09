//
//  HAVersionModel.m
//  华奥移动
//
//  Created by un2lock on 15/3/6.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAVersionModel.h"

@implementation HAVersionModel
+(instancetype)versionWithDict:(NSDictionary *)dict{
    HAVersionModel *model =[[HAVersionModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
