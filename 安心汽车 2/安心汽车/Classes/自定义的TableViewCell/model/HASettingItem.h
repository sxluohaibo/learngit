//
//  HASettingItem.h
//  华奥移动
//
//  Created by tusm on 15-3-4.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    HASettingItemTypeNone, // 什么也没有
    HASettingItemTypeArrow, // 箭头
    HASettingItemTypeSwitch // 开关
} HASettingItemType;

typedef enum {
    HASettingItemTypeCenter, // 蹭
    HASettingItemTypeLeft, // 左对齐
    HASettingItemTypeRight, // 右对齐
    HASettingItemTypeDefault
} HASettingItemAlignType;


@interface HASettingItem : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) HASettingItemType type;// Cell的样式
@property(nonatomic,assign) UIColor *color;
@property (assign) HASettingItemAlignType *aligntype;
@property (nonatomic, copy) void (^operation)() ; // 点击cell后要执行的操作
@property (nonatomic, copy) UIImageView *desImage;

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title type:(HASettingItemType)type;

@end
