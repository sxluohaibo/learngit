//
//  HA4SRequestResult.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/27.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  请求返回模型

#import <Foundation/Foundation.h>

@interface HA4SRequestResult : NSObject

/**newsId-资讯编号*/
@property(nonatomic,assign) int newsId;

/**newsId-资讯标题*/
@property(nonatomic,copy) NSString* title;

/**newsId-资讯概要*/
@property(nonatomic,copy) NSString* summary;

/**newsId-该资讯最后编辑时间*/
@property(nonatomic,copy) NSString* updateTime;

@end
