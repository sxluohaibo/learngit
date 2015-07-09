//
//  HASettingItem.m
//  华奥移动
//
//  Created by tusm on 15-3-4.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HASettingItem.h"

@implementation HASettingItem
+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title type:(HASettingItemType)type{
    HASettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.type = type;
    //默认左对齐
    item.aligntype = HASettingItemTypeLeft;
    return item;
}
@end
