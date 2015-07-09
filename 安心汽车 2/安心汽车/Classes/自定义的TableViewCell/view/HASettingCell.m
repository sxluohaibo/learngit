//
//  HASettingCell.m
//  华奥移动
//
//  Created by tusm on 15-3-4.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HASettingCell.h"
#import "HASettingItem.h"

@interface HASettingCell()
{
    UIImageView *_arrow;
    UISwitch *_switch;
}
@end

@implementation HASettingCell

+ (id)settingCellWithTableView:(UITableView *)tableView
{
    // 0.用static修饰的局部变量，只会初始化一次
    static NSString *ID = @"Cell";
    
    // 1.拿到一个标识先去缓存池中查找对应的Cell
    HASettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.如果缓存池中没有，才需要传入一个标识创建新的Cell
    if (cell == nil) {
        cell = [[HASettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setItem:(HASettingItem *)item
{
    _item = item;
    // 设置数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    
    if (item.type == HASettingItemTypeArrow) {
        if (_arrow == nil) {
            _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
        }
        
        // 右边显示箭头
        self.accessoryView = _arrow;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    } else if (item.type == HASettingItemTypeSwitch) {
        
        if (_switch == nil) {
            _switch = [[UISwitch alloc] init];
        }
        
        // 右边显示开关
        self.accessoryView = _switch;
        // 禁止选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else {
        
        // 什么也没有，清空右边显示的view
        self.accessoryView = nil;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    }
    
    //设置背景颜色
    self.backgroundColor=_item.color;
    
//    NSTextAlignmentLeft      = 0,    // Visually left aligned
//#if TARGET_OS_IPHONE
//    NSTextAlignmentCenter    = 1,    // Visually centered
//    NSTextAlignmentRight     = 2,    // Visually right aligned
//#else /* !TARGET_OS_IPHONE */
//    NSTextAlignmentRight     = 1,    // Visually right aligned
//    NSTextAlignmentCenter    = 2,
    
//    HASettingItemTypeCenter, // 蹭
//    HASettingItemTypeLeft, // 左对齐
//    HASettingItemTypeRight // 右对齐
    if(item.aligntype==HASettingItemTypeLeft){
        self.textLabel.textAlignment=NSTextAlignmentLeft;
    }else if(item.aligntype==HASettingItemTypeRight){
        self.textLabel.textAlignment=NSTextAlignmentRight;
    }else if(item.aligntype==HASettingItemTypeCenter){
        self.textLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    
}

@end
