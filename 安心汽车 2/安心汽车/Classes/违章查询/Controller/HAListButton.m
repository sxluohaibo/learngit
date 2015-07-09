//
//  HAListButton.m
//  安心汽车
//
//  Created by kongw on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAListButton.h"

@implementation HAListButton
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)buttonListArr:(NSArray *)listArr{
    if (listArr.count == 1) {
        UILabel *titleName = [[UILabel alloc] init];
        titleName.backgroundColor = [UIColor clearColor];
        titleName.frame = CGRectMake(30, 10, 150, 24);
        titleName.textAlignment = NSTextAlignmentLeft;
        titleName.textColor = HAColor(95, 119, 146);
        titleName.text = [listArr objectAtIndex:0];
        [self addSubview:titleName];
        
    }else if (listArr.count == 2){
        for (int i = 0; i < listArr.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor clearColor];
            [button addTarget:self action:@selector(delteButton:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:[NSString stringWithFormat:@"%@",[listArr objectAtIndex:i]] forState:UIControlStateNormal];
            button.frame = CGRectMake(25+ 70*i, 0, 60, 44);
            [self addSubview:button];
        }
    }else if (listArr.count == 3){
        for (int i = 0; i < listArr.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor clearColor];
            [button addTarget:self action:@selector(delteButton:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:[NSString stringWithFormat:@"%@",[listArr objectAtIndex:i]] forState:UIControlStateNormal];
            button.frame = CGRectMake(i*70, 0, 60, 44);
            [self addSubview:button];
        }
    }else{
        for (int i = 0; i < listArr.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor clearColor];
            [button addTarget:self action:@selector(delteButton:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            [button setTitle:[NSString stringWithFormat:@"%@",[listArr objectAtIndex:i]] forState:UIControlStateNormal];
            NSInteger x = i*65;
            NSInteger y = 0;
            if (i/3 == 1) {
                x = (i%3)*65;
                y = 22;
            }
            button.frame = CGRectMake(x, y, 55, 21);
            [self addSubview:button];
        }
    }
}

- (void)delteButton:(UIButton *)sender{
    [delegate deleteRefreshView:sender];
}

@end
