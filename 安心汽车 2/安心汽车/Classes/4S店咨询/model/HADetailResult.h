//
//  HADetailResult.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/29.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HA4SRequestResult;

@interface HADetailResult : NSObject
/**newsId-资讯标题*/
@property(nonatomic,copy) NSString* title;

/**newsId-资讯概要*/
@property(nonatomic,copy) NSString* content;

/**newsId-该资讯最后编辑时间*/
@property(nonatomic,copy) NSString* updateTime;


+ (instancetype)DetailResultWithTitle:(NSString *)title content:(NSString *) content updateTime:(NSString *)updateTime;

@end
