//
//  HACityView.m
//  安心汽车
//
//  Created by kongw on 15/3/19.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACityView.h"

@implementation HACityView{
    UIImageView *iconImage;
    UILabel *temperature_detail;
    UILabel *temperature_average;
    UILabel *temperature;
    UILabel *description;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = YES;
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [self addGestureRecognizer:tap];

        //显示天气的图片
        iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
        [self addSubview:iconImage];
        
        //天气详情
        temperature_detail  = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 90, 20)];
        //temperature_detail.text = [today objectForKey:@"weather"];
        temperature_detail.font = [UIFont systemFontOfSize:14.0f];
        temperature_detail.textColor = RGBACOLOR(232, 164, 38, 1);
        temperature_detail.textAlignment = NSTextAlignmentCenter;
        temperature_detail.backgroundColor = [UIColor clearColor];
        [self addSubview:temperature_detail];
        
        //平均温度
        temperature_average  = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 100, 40)];
        //NSString *average = [[[weatherInfo objectForKey:@"result"] objectForKey:@"sk"] objectForKey:@"temp"];
        //temperature_average.text = [NSString stringWithFormat:@"%@℃",average];
        temperature_average.font = [UIFont systemFontOfSize:24.0f];
        temperature_average.textAlignment = NSTextAlignmentCenter;
        temperature_average.textColor = RGBACOLOR(232, 164, 38, 1);
        temperature_average.backgroundColor = [UIColor clearColor];
        [self addSubview:temperature_average];
        
        //温度
        temperature  = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, 100, 30)];
        temperature.textAlignment = NSTextAlignmentCenter;
        temperature.textColor = RGBACOLOR(232, 164, 38, 1);
        //temperature.text = [today objectForKey:@"temperature"];
        temperature.backgroundColor = [UIColor clearColor];
        [self addSubview:temperature];
        
        //描述
        description  = [[UILabel alloc] initWithFrame:CGRectMake(90, 70, 100, 20)];
        //description.text = [today objectForKey:@"dressing_advice"];
        description.textColor = RGBACOLOR(232, 164, 38, 1);
        description.font = [UIFont systemFontOfSize:14.0f];
        description.textAlignment = NSTextAlignmentCenter;
        description.backgroundColor = [UIColor clearColor];
        [self addSubview:description];
    }
    return self;
}

- (void)tapView:(UIGestureRecognizer *)tap{
    HAMainViewController *mainVc = (HAMainViewController *)[self viewController];
    HACityInfoViewController *cityInfo = [[HACityInfoViewController alloc] init];
    [mainVc.navigationController pushViewController:cityInfo animated:YES];
    
}
@end
