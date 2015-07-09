//
//  HAMapViewController.h
//  安心汽车
//
//  Created by kongw on 15/4/30.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "HAWindowViewController.h"

@interface HAMapViewController : HAWindowViewController<MKMapViewDelegate>{
    MKMapView * mapView;
}

@property (nonatomic, strong) NSDictionary *mapDic;

@end
