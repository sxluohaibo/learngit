//
//  HAUserDefaultTool.h
//  安心汽车
//
//  Created by un2lock on 15/4/13.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAUserDefaultTool : NSObject
/*保存key和value*/
+(void)saveValueWith:(NSString *)key Andvalue:(NSString *) value;
/*从沙盒中获取值*/
+(NSString *) getValueWithKey:(NSString *) key;
@end
