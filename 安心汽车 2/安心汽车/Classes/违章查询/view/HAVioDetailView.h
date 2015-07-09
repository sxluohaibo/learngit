//
//  HAVioDetailView.h
//  安心汽车
//
//  Created by un2lock on 15/5/5.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HAVioDetailView : UIScrollView<CityNameDelegate>{
    MKMapView *mapView;
}
@property (nonatomic, strong) NSDictionary *detailDic;
@end
