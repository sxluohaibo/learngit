//
//  HA4STableViewCell.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/28.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HA4STableViewCell.h"
#import "HA4SRequestResult.h"
#import "HA4sFrame.h"
//咨询模块的边距
#define MessageMargin 3

@interface HA4STableViewCell ()


/**
 *  时间标签
 */
@property (nonatomic, strong) UILabel *timelabelView;
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) UILabel *mytitleLabel;
@property (nonatomic, strong) UILabel *mydetailLable;


@end


@implementation HA4STableViewCell



- (UILabel *)labelView
{
    if (_timelabelView == nil) {
        _timelabelView = [[UILabel alloc] init];
        _timelabelView.bounds = CGRectMake(0, 0, 100, 30);
        _timelabelView.backgroundColor = [UIColor redColor];
        _timelabelView.font = [UIFont systemFontOfSize:11];
    }
    return _timelabelView;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"message";
    HA4STableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HA4STableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉线
      }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //添加控件
        [self setupContain];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setupContain{
    //1、图片
    UIImageView * iconView = [[UIImageView alloc] init];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    //2、咨询标题
    UILabel * mytitleLabel = [[UILabel alloc] init];
    mytitleLabel.numberOfLines = 0;
    mytitleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:mytitleLabel];
    self.mytitleLabel = mytitleLabel;
    
    //3、咨询详情
    UILabel * mydetailLable = [[UILabel alloc] init];
    mydetailLable.numberOfLines = 0;
    mydetailLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:mydetailLable];
    self.mydetailLable = mydetailLable;
    
    //4、咨询时间
    UILabel * timelabelView = [[UILabel alloc] init];
    timelabelView.numberOfLines = 0;
    timelabelView.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:timelabelView];
    self.timelabelView = timelabelView;
    
    //5底部的线
}



- (void)setItem:(HA4sFrame *)item
{
    _item = item;
    
    //1、设置尺寸
    [self setupFrame];
    
    //2、设置内容
    [self setupContain:item.message];
}

- (void)setupFrame
{
    self.iconView.frame = self.item.iconF;
    self.mytitleLabel.frame = self.item.titleF;
    self.mydetailLable.frame = self.item.detailTitleF;
    self.timelabelView.frame = self.item.timeTitleF;
}


- (void)setupContain:(HA4SRequestResult *)result
{
    self.iconView.image = [UIImage imageNamed:@"call_ico"];
    self.mytitleLabel.text = result.title;
    self.mydetailLable.text = result.summary;
    self.timelabelView.text = result.updateTime;
}


@end
