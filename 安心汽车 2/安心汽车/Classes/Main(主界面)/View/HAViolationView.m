//
//  HAViolationView.m
//  安心汽车
//
//  Created by kongw on 15/3/27.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAViolationView.h"

@implementation HAViolationView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [self addGestureRecognizer:tap];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
        title.text = @"今日限行的尾号";
        title.font = [UIFont systemFontOfSize:14.0f];
        title.textColor = [UIColor whiteColor];
        [self addSubview:title];
        
        
        UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 100, 25)];
        number.tag = 99;
        number.textAlignment = NSTextAlignmentCenter;
        number.font = [UIFont systemFontOfSize:22.0f];
        number.textColor = [UIColor redColor];
        [self addSubview:number];
    }
    return self;
}

- (void)initVoilationView:(NSDictionary *)dic{
    UILabel *textLabel = (UILabel *)[self viewWithTag:99];
    if ([[dic objectForKey:@"reason"] isEqualToString:@"该城市限行"]) {
        self.userInteractionEnabled = YES;
        NSArray *tempArr = [dic objectForKey:@"limitNo"];
        NSArray *numberArr = [tempArr objectAtIndex:0];
        if ((numberArr != nil && ![numberArr isKindOfClass:[NSNull class]] && numberArr.count != 0)) {
            textLabel.text = [NSString stringWithFormat:@"%@ - %@",[numberArr objectAtIndex:0],[numberArr objectAtIndex:1]];
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.font = [UIFont systemFontOfSize:22.0f];
            textLabel.textColor = [UIColor redColor];
            [self addSubview:textLabel];
        }else{
            textLabel.text = @"今天不限行";
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.font = [UIFont systemFontOfSize:14.0f];
            textLabel.textColor = [UIColor redColor];
            [self addSubview:textLabel];
        }
    }else if ([[dic objectForKey:@"reason"] isEqualToString:@"该城市不限行"]){
        self.userInteractionEnabled = NO;
        textLabel.text = @"该城市不限行";
        textLabel.font = [UIFont systemFontOfSize:14.0f];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor redColor];
        [self addSubview:textLabel];
    }
}

- (void)tapView:(UIGestureRecognizer *)tap{
    HAXIanXingViewController *controller=[[HAXIanXingViewController alloc] init];
    [[self viewController].navigationController pushViewController:controller animated:YES];
}

@end
