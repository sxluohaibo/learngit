//
//  GprsGetCity.h
//  MsMedia
//
//  Created by eg365 on 13-4-7.
//  Copyright (c) 2013年 cn.eg365.eg36501. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CityNameDelegate <NSObject>
//天气回调方法，用于传回获取到的天气信息//天气数组，存放三天的天气字典
@optional
- (void)getCityName:(NSString *)object;
- (void)getPlaceName:(CLRegion *)placeName;

@end

@interface GprsGetCity : NSObject<CLLocationManagerDelegate>{
    CLLocationManager *locationCity;
    NSString *location;
    id <CityNameDelegate>cityDelegate;
}


@property (nonatomic, strong) id<CityNameDelegate>cityDelegate;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *placeName;//传入的地名
+ (GprsGetCity *)shareGetCityLocation;
- (void)initGetCityData:(NSString *)cityName;
@end
