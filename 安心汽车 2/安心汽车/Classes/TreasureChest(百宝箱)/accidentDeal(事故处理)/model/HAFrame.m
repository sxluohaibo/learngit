//
//  HAFrame.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/17.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAFrame.h"
#import "HADuty.h"

@implementation HAFrame





- (void)setDuty:(HADuty *)duty
{
    _duty = duty;
    
    //设置文字尺寸
    
    CGSize size =  [duty.title sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(320, 100)];
    _titleF = (CGRect){{5,5},size};
    
    
    CGFloat imageViewY = CGRectGetMaxY(_titleF);
    CGFloat imageViewW = 150;
    CGFloat imageViewH = 150;
    CGFloat imageViewX = ScreenWidth*0.5 - imageViewW*0.5;
    _iconF = (CGRect){imageViewX,imageViewY,imageViewW,imageViewH};
    
    
    _cellHeight = CGRectGetMaxY(_iconF) + 5;
}


+(instancetype)FrameWithDuty:(HADuty *)duty
{
    HAFrame * frame = [[self alloc] init];
    frame.duty = duty;
    return frame;
}

- (instancetype)initWithDuty:(HADuty *)duty
{
    return [HAFrame FrameWithDuty:duty];
}


@end
