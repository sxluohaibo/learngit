//
//  MJSettingItem.h
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  每一个cell都应一个MJSettingItem模型

#import <Foundation/Foundation.h>



@interface MJSettingItem : NSObject
/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  标题
 */
@property (nonatomic, copy) NSString *detail;



+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title detail:(NSString *)detail;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;


+ (instancetype)itemWithTitle:(NSString *)title;
@end
