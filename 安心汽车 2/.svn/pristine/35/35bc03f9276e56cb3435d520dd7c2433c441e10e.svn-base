//
//  HATopView.h
//  安心汽车
//
//  Created by kongw on 15/4/23.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

@protocol HATopViewDelegate <NSObject>

- (void)changCity;

@end
#import <UIKit/UIKit.h>

@interface HATopView : UIImageView

@property(strong,nonatomic)id<HATopViewDelegate>delegate;

//刷新界面
- (void)initrefreshWeather:(NSDictionary *)weatherData;
- (void)initrefreshStopwalk:(NSDictionary *)vioData;
@end
