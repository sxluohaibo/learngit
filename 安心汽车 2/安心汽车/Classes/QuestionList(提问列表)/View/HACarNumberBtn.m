//
//  HACarNumberBtn.m
//  安心汽车
//
//  Created by un2lock on 15/5/12.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACarNumberBtn.h"

@implementation HACarNumberBtn
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        [self setImage:[UIImage imageNamed:@"dd_list_icon"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"dd_list_icon"] forState:UIControlStateSelected];
        [self setBackgroundImage:[UIImage imageNamed:@"blue_bar"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"blue_bar"] forState:UIControlStateSelected];
//        self.titleLabel.textColor=[UIColor whiteColor];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self setTitle:@"请选择车型" forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 如果仅仅是调整按钮内部titleLabel和imageView的位置，那么在layoutSubviews中单独设置位置即可
    
    // 1.计算titleLabel的frame
    self.titleLabel.x = self.imageView.x;
    //self.titleLabel.backgroundColor = [UIColor redColor]; 
    // 2.计算imageView的frame
    //self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)-10;
    self.imageView.x=self.width-20;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 只要修改了文字，就让按钮重新计算自己的尺寸
//    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    // 只要修改了图片，就让按钮重新计算自己的尺寸
//    [self sizeToFit];
}

@end
