//
//  GprsGetCity.m
//  MsMedia
//
//  Created by eg365 on 13-4-7.
//  Copyright (c) 2013年 cn.eg365.eg36501. All rights reserved.
//

#import "GprsGetCity.h"

static GprsGetCity *getCity = nil;

@implementation GprsGetCity
@synthesize location;
@synthesize cityDelegate;
@synthesize placeName;

+ (GprsGetCity *)shareGetCityLocation{
    if (!getCity) {
        getCity = [[GprsGetCity alloc] init];
    }
    return getCity;
}

- (void)initGetCityData:(NSString *)cityName{
    placeName = cityName;//传入地名
    locationCity = [[CLLocationManager alloc]init];
    locationCity.delegate = self;
    //准确度
    locationCity.desiredAccuracy=kCLLocationAccuracyKilometer;
    locationCity.distanceFilter=1000.0f;
    [locationCity startUpdatingLocation];
}


//ios8的定位的方法
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status){
        case kCLAuthorizationStatusNotDetermined:{
            if ([locationCity respondsToSelector:@selector(requestAlwaysAuthorization)]){
                NSLog(@"IOS8定位系统");
                [locationCity requestAlwaysAuthorization];
            }
        }
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{
    //纬度
    //NSString* latitude=[NSString stringWithFormat:@"%g",newLocation.coordinate.latitude];
    //经度
    //NSString* longitude=[NSString stringWithFormat:@"%g",newLocation.coordinate.longitude];
    //NSLog(@"当前城市经纬度{%@,%@}",latitude,longitude);
    //转换经纬度变成可读信息
    CLGeocoder* geoCoder = [[CLGeocoder alloc] init];
    NSLog(@"placeName == %@",placeName);
    if (![placeName isEqualToString:@""]) {
        [geoCoder geocodeAddressString:placeName completionHandler:^(NSArray *placemarks, NSError *error) {
            CLRegion *clRegion;
            for (CLPlacemark *placeMark in placemarks){
                clRegion = placeMark.region;
            }
            [cityDelegate getPlaceName:clRegion];
        }];
    }else{
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark *placeMark in placemarks){
                location = placeMark.locality;
                NSLog(@"定位成功22 == %@",location);
                [[NSUserDefaults standardUserDefaults] setObject:location forKey:dwCityName];
                [cityDelegate getCityName:location];
            }
        }];
    }
    //如果没有城市
    if (location.length <= 0) {
        [locationCity stopUpdatingLocation];
    }else{
        [locationCity stopUpdatingLocation];
    }
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    //NSLog(@"------------GPS----Error");
    [cityDelegate getCityName:@"定位失败"];
    //[[NSUserDefaults standardUserDefaults] setObject:nil forKey:dwCityName];
    [locationCity stopUpdatingLocation];
    //[[UIApplication sharedApplication].keyWindow makeToast:@"请在系统设置中打开\"定位服务\"来确定位置"];
}

@end
