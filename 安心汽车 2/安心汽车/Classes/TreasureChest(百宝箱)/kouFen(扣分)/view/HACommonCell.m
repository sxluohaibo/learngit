//
//  HACommonCell.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/20.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACommonCell.h"


@interface HACommonCell()

@property(nonatomic,strong) UIImageView * iconView;

@end

@implementation HACommonCell




+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString * ID = @"Dutyasss";
    HACommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[HACommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UIImageView * actionView = [[UIImageView alloc] init];
        self.iconView = actionView;
        actionView.frame = CGRectMake((ScreenWidth-165)*0.5, 5,160, 165);
//        self.backgroundColor = [UIColor lightGrayColor];
        self.userInteractionEnabled = NO;
        [self.contentView addSubview:actionView];
    }
    
    return self;
}



- (void)setName:(NSString *)name
{
    _name = name;
    
    self.iconView.image = [UIImage imageNamed:name];
}




@end
