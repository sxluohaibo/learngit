//
//  HAMapViewController.m
//  安心汽车
//
//  Created by kongw on 15/4/30.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAMapViewController.h"

@interface HAMapViewController ()
@end

@implementation HAMapViewController
@synthesize mapDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    mapView.delegate = self;
    [self.view addSubview:mapView];
    NSArray *array = [[NSArray alloc] initWithObjects:mapDic, nil];
    [self setAnnotionsWithList:array];
}

-(void)setAnnotionsWithList:(NSArray *)list{
    for (NSDictionary *dic in list) {
        CLLocationDegrees latitude=[[dic objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude=[[dic objectForKey:@"longitude"] doubleValue];
        CLLocationCoordinate2D location=CLLocationCoordinate2DMake(latitude, longitude);
        
        MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(location,180 ,180);
        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:region];
        [mapView setRegion:adjustedRegion animated:YES];
        
        BasicMapAnnotation *  annotation=[[BasicMapAnnotation alloc] initWithLatitude:latitude andLongitude:longitude];
        [mapView addAnnotation:annotation];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
@end
