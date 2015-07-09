//
//  HADutyCell.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/17.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HADutyCell.h"
#import "HAFrame.h"
#import "HADuty.h"
@interface HADutyCell()

@property(nonatomic,weak)UILabel * text;
@property(nonatomic,weak)UIImageView * iconView;

@end



@implementation HADutyCell




+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString * ID = @"Duty";
    HADutyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[HADutyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //添加控件
        [self setuptool];
    }
    return self;
}




//添加控件
- (void)setuptool
{
    //顶部文字
    UILabel * textLable = [[UILabel alloc] init];
//    textLable.backgroundColor = [UIColor lightGrayColor];
    self.text = textLable;
    textLable.numberOfLines = 0;
    textLable.font = [UIFont systemFontOfSize:13];
//    textLable.lineBreakMode = UILineBreakModeWordWrap;
    [self.contentView addSubview:textLable];
    
    //下面的图片
    UIImageView * imageView = [[UIImageView alloc] init];
    self.iconView = imageView;
//    imageView.backgroundColor = [UIColor lightGrayColor];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:imageView];
    
    
}


- (void)setCellFram:(HAFrame *)cellFram
{
    _cellFram = cellFram;
    
    
    HADuty * duty = cellFram.duty;
    self.text.frame = cellFram.titleF;
//    NSLog(@"sdasdasd%@",NSStringFromCGRect(cellFram.titleF));
    self.text.text = duty.title;
    UIImage * image = [UIImage imageNamed:duty.icon];
    self.iconView.image = image;
//    self.iconView.image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];;
    self.iconView.frame = cellFram.iconF;
}

@end
