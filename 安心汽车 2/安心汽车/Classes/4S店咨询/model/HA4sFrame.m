//
//  HA4sFrame.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/28.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HA4sFrame.h"
#import "HA4SRequestResult.h"


#define MessageMargin 3

@implementation HA4sFrame

- (void)setMessage:(HA4SRequestResult *)message
{
    _message = message;
    
    //1、设置头像
    CGFloat iconViewX = MessageMargin;
    CGFloat iconViewY = MessageMargin;
    CGFloat iconViewW = 60;
    CGFloat iconViewH = 60;
    _iconF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);

    //2、设置标题
    CGFloat mytitleLabelX = iconViewX+ iconViewW + MessageMargin;
    CGFloat mytitleLabelY = MessageMargin;
    CGFloat mytitleLabelW = ScreenWidth -  iconViewW - 3 * MessageMargin;
    
    CGSize titleSize = [message.title sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(mytitleLabelW, MAXFLOAT)];
    _titleF = CGRectMake(mytitleLabelX, mytitleLabelY, titleSize.width  , titleSize.height);
  
    
    //3、咨询详情
    CGFloat mydetailLableX = mytitleLabelX;
    CGFloat mydetailLableY = mytitleLabelY +  titleSize.height + MessageMargin;
    CGSize mydetailsize = [message.summary sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(mytitleLabelW, MAXFLOAT)];
    _detailTitleF = CGRectMake(mydetailLableX, mydetailLableY, mydetailsize.width, mydetailsize.height);
    
    //4、设置时间
    CGFloat timelabelViewX = mydetailLableX;
    CGFloat timelabelViewY = mydetailLableY+ mydetailsize.height + MessageMargin;
    
    CGFloat timelabelViewW = 200;
    CGFloat timelabelViewH = 30;
    _timeTitleF = CGRectMake(timelabelViewX, timelabelViewY, timelabelViewW, timelabelViewH);
   
    
    //cell高度
    _cellHeight = timelabelViewY + timelabelViewH + MessageMargin;
    
}

+(instancetype)FrameWith4SRequestResult:(HA4SRequestResult *)item
{
    HA4sFrame * frame = [[self alloc] init];
    frame.message = item;
    return frame;
}

- (instancetype)initWithDuty:(HA4SRequestResult *)item
{
    return [HA4sFrame FrameWith4SRequestResult:item];
}
@end
