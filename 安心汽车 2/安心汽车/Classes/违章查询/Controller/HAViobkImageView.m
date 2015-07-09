//
//  HAViobkImageView.m
//  安心汽车
//
//  Created by kongw on 15/5/4.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAViobkImageView.h"

@implementation HAViobkImageView

- (id)initWithFrame:(CGRect)frame andIndex:(NSString *)index{
    self = [super initWithFrame:frame];
    if (self) {
        //NSLog(@"1111 == %@",index);
        if ([index isEqualToString:violationArea]) {
            self.image = [UIImage imageNamed:@"wz_list_01.jpg"];
        }else if ([index isEqualToString:remarkNO]){
            self.image = [UIImage imageNamed:@"wz_list_03.jpg"];
        }else{
            self.image = [UIImage imageNamed:@"wz_list_02.jpg"];
        }
    }
    return self;
}

@end
