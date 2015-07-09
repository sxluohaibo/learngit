//
//  HAVioDetailView.m
//  安心汽车
//
//  Created by un2lock on 15/5/5.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAVioDetailView.h"

#define NormalPadding 20
#define NormalTopPadding 15

@interface HAVioDetailView()<MKMapViewDelegate>

/**违章地点 label*/
@property(nonatomic,strong)UILabel *areaContentLabel;
@property(nonatomic,strong)UILabel *actContentLabel;
@property(nonatomic,strong)UILabel *timeContentLabel;
@property(nonatomic,strong)UILabel *handlerContentLabel;
@property(nonatomic,strong)UILabel *fenContentLabel;
@property(nonatomic,strong)UILabel *moneyContentLabel;
@end
@implementation HAVioDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        //违章地点
        CGFloat areaLabelX=NormalPadding;
        CGFloat areaLabelY=NormalTopPadding;
        CGFloat areLabelW=70;
        CGFloat areaLabelH=30;
        UILabel *areLabel=[[UILabel alloc] initWithFrame:CGRectMake(areaLabelX, areaLabelY, areLabelW, areaLabelH)];
        areLabel.font=[UIFont systemFontOfSize:15.0];
        areLabel.text=@"违章地点";
        areLabel.textColor=HAColor(150, 150, 150);
        [self addSubview:areLabel];
        
        
        CGFloat areaContentLabelX=CGRectGetMaxX(areLabel.frame);
        CGFloat areaContentLabelY=areaLabelY;
        CGFloat areaContentLabelW=ScreenWidth -areaContentLabelX - NormalPadding;
        CGSize areaContentSize=[self sizeWithText:@"北京市朝阳区朝阳北路青年路口至四季星河西路南口段" font:[UIFont systemFontOfSize:15.0] maxW:areaContentLabelW];
        UILabel *areaContentLabel=[[UILabel alloc] initWithFrame:CGRectMake(areaContentLabelX, areaContentLabelY, areaContentSize.width, areaContentSize.height)];
        
        
        areaContentLabel.textColor=HAColor(20, 125, 177);
        areaContentLabel.numberOfLines=0;
        areaContentLabel.textAlignment=NSTextAlignmentLeft;
        areaContentLabel.font=[UIFont systemFontOfSize:15.0];
        _areaContentLabel=areaContentLabel;
        [self addSubview:areaContentLabel];
        
        //违章内容
        CGFloat actLabelX=NormalPadding;
        CGFloat actLabelY=MAX(CGRectGetMaxY(areLabel.frame), CGRectGetMaxY(areaContentLabel.frame)) + 10 ;
        CGFloat actLabelW=areLabelW;
        CGFloat actLabelH=areaLabelH;
        UILabel *actLabel=[[UILabel alloc] initWithFrame:CGRectMake(actLabelX, actLabelY, actLabelW, actLabelH)];
        actLabel.font=[UIFont systemFontOfSize:15.0];
        actLabel.text=@"违章内容";
        actLabel.textColor=HAColor(150, 150, 150);
        [self addSubview:actLabel];
        
        
        CGFloat actContentLabelX=CGRectGetMaxX(actLabel.frame);
        CGFloat actContentLabellY=actLabelY;
        CGFloat actContentLabelW=ScreenWidth -actContentLabelX - NormalPadding;
        CGSize actContentSize=[self sizeWithText:@"不按规定停放影响其他车辆和行人通行的" font:[UIFont systemFontOfSize:15.0] maxW:actContentLabelW];
        UILabel *actContentLabel=[[UILabel alloc] initWithFrame:CGRectMake(actContentLabelX, actContentLabellY, actContentSize.width, actContentSize.height)];
        actContentLabel.textColor=HAColor(20, 125, 177);
        actContentLabel.numberOfLines=0;
        actContentLabel.font=[UIFont systemFontOfSize:15.0];

        _actContentLabel=actContentLabel;
        [self addSubview:actContentLabel];
        
        
        //违章时间
        CGFloat timeLabelX=NormalPadding;
        CGFloat timeLabelY=MAX(CGRectGetMaxY(actLabel.frame), CGRectGetMaxY(actContentLabel.frame)) + 10 ;
        CGFloat timeLabelW=areLabelW;
        CGFloat timeLabelH=areaLabelH;
        UILabel *timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH)];
        timeLabel.font=[UIFont systemFontOfSize:15.0];
        timeLabel.text=@"违章时间";
        timeLabel.textColor=HAColor(150, 150, 150);
        [self addSubview:timeLabel];
        
        
        CGFloat timeContentLabelX=CGRectGetMaxX(actLabel.frame);
        CGFloat timeContentLabellY=timeLabelY + 3;
        CGFloat timeContentLabelW=ScreenWidth -actContentLabelX - NormalPadding;
        CGSize timeContentSize=[self sizeWithText:@"2014-06-22 19:46:00" font:[UIFont systemFontOfSize:15.0] maxW:timeContentLabelW];
        UILabel *timeContentLabel=[[UILabel alloc] initWithFrame:CGRectMake(timeContentLabelX, timeContentLabellY, timeContentSize.width, timeContentSize.height)];
        timeContentLabel.textColor=HAColor(20, 125, 177);
        timeContentLabel.numberOfLines=0;
        timeContentLabel.font=[UIFont systemFontOfSize:15.0];
        
        _timeContentLabel=timeContentLabel;
        [self addSubview:timeContentLabel];
        
        
        //当前处理状态
        CGFloat handlerLabelX=NormalPadding;
        CGFloat handlerLabelY=MAX(CGRectGetMaxY(timeLabel.frame), CGRectGetMaxY(timeContentLabel.frame)) + 10 ;
        CGFloat handlerLabelW=timeLabelW;
        CGFloat handlerLabelH=timeLabelH;
        UILabel *handlerLabel=[[UILabel alloc] initWithFrame:CGRectMake(handlerLabelX, handlerLabelY, handlerLabelW, handlerLabelH)];
        handlerLabel.font=[UIFont systemFontOfSize:15.0];
        handlerLabel.text=@"当前状态";
        handlerLabel.textColor=HAColor(150, 150, 150);
        [self addSubview:handlerLabel];
        
        
        CGFloat handlerContentLabelX=CGRectGetMaxX(actLabel.frame);
        CGFloat handlerContentLabellY=handlerLabelY +3;
        CGFloat handlerContentLabelW=ScreenWidth -actContentLabelX - NormalPadding;
        CGSize handlerContentSize=[self sizeWithText:@" 未处理 " font:[UIFont systemFontOfSize:15.0] maxW:handlerContentLabelW];
        UILabel *handlerContentLabel=[[UILabel alloc] initWithFrame:CGRectMake(handlerContentLabelX, handlerContentLabellY, handlerContentSize.width, handlerContentSize.height)];
        handlerContentLabel.textColor=HAColor(20, 125, 177);
        handlerContentLabel.numberOfLines=0;
        handlerContentLabel.font=[UIFont systemFontOfSize:15.0];
        
        _handlerContentLabel=handlerContentLabel;
        [self addSubview:handlerContentLabel];
        
        
        //罚款金额
        CGFloat moneyLabelX=NormalPadding;
        CGFloat moneyLabelY=MAX(CGRectGetMaxY(handlerContentLabel.frame), CGRectGetMaxY(handlerContentLabel.frame)) + 10 ;
        CGFloat moneyLabelW=areLabelW;
        CGFloat moneyLabelH=areaLabelH;
        UILabel *moneyLabel=[[UILabel alloc] initWithFrame:CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH)];
        moneyLabel.font=[UIFont systemFontOfSize:15.0];
        moneyLabel.text=@"罚款金额";
        moneyLabel.textColor=HAColor(150, 150, 150);
        [self addSubview:moneyLabel];
        
        
        CGFloat moneyContentLabelX=CGRectGetMaxX(actLabel.frame);
        CGFloat moneyContentLabellY=moneyLabelY + 3;
        //CGFloat moneyContentLabelW = ScreenWidth -actContentLabelX - NormalPadding;
        CGSize moneyContentSize=[self sizeWithText:@" 200 (元/人民币)  " font:[UIFont systemFontOfSize:15.0] maxW:timeContentLabelW];
        UILabel *moneyContentLabel=[[UILabel alloc] initWithFrame:CGRectMake(moneyContentLabelX, moneyContentLabellY, moneyContentSize.width, moneyContentSize.height)];
        moneyContentLabel.textColor=HAColor(20, 125, 177);
        moneyContentLabel.numberOfLines=0;
        moneyContentLabel.font=[UIFont systemFontOfSize:15.0];
        
        _moneyContentLabel=moneyContentLabel;
        [self addSubview:moneyContentLabel];

        //扣分情况
        
        CGFloat fenLabelX=NormalPadding;
        CGFloat fenLabelY=MAX(CGRectGetMaxY(moneyLabel.frame), CGRectGetMaxY(moneyContentLabel.frame)) + 10 ;
        CGFloat fenLabelW=areLabelW;
        CGFloat fenLabelH=areaLabelH;
        UILabel *fenLabel=[[UILabel alloc] initWithFrame:CGRectMake(fenLabelX, fenLabelY, fenLabelW, fenLabelH)];
        fenLabel.font=[UIFont systemFontOfSize:15.0];
        fenLabel.text=@"扣分情况";
        fenLabel.textColor=HAColor(150, 150, 150);
        [self addSubview:fenLabel];
        
        
        CGFloat fenContentLabelX=CGRectGetMaxX(actLabel.frame);
        CGFloat fenContentLabellY=fenLabelY + 4;
        CGFloat fenContentLabelW=ScreenWidth -actContentLabelX - NormalPadding;
        CGSize fenContentSize=[self sizeWithText:@"没有扣分" font:[UIFont systemFontOfSize:15.0] maxW:fenContentLabelW];
        UILabel *fenContentLabel=[[UILabel alloc] initWithFrame:CGRectMake(fenContentLabelX, fenContentLabellY, fenContentSize.width, fenContentSize.height)];
        fenContentLabel.textColor=HAColor(20, 125, 177);
        fenContentLabel.numberOfLines=0;
        fenContentLabel.font=[UIFont systemFontOfSize:15.0];
        
        _fenContentLabel = fenContentLabel;
        [self addSubview:fenContentLabel];
        
        //地图
        mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, fenContentLabellY+fenContentSize.height+10, ScreenWidth, 300)];
        mapView.delegate = self;
        [self addSubview:mapView];
        //239.370000
        self.contentSize = CGSizeMake(ScreenWidth, fenContentLabellY+fenContentSize.height +10+300);
    }
    return self;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

-(void)setDetailDic:(NSDictionary *)detailDic{
    _detailDic=detailDic;
    
    //赋值
    
    //违章地点
    _areaContentLabel.text=detailDic[@"area"];
    _actContentLabel.text=detailDic[@"act"];
    
    _timeContentLabel.text=detailDic[@"date"];
    
    NSString *handled=detailDic[@"handled"];
    if([@"0" isEqualToString:handled]){
        _handlerContentLabel.text=@"未处理";
    }else{
        _handlerContentLabel.text=@"已处理";
    }
    NSString *money=[NSString stringWithFormat:@"%@ (元/人民币)",detailDic[@"money"]];
    _moneyContentLabel.text=money;
    NSString *fen=detailDic[@"fen"];
    if([@"0" isEqualToString:fen]){
        _fenContentLabel.text=@"没有扣分";
    }else{
        _fenContentLabel.text=[NSString stringWithFormat:@"%@ 分",fen];
    }
    [[GprsGetCity shareGetCityLocation] initGetCityData:_detailDic[@"area"]];
    [[GprsGetCity shareGetCityLocation] setCityDelegate:self];
}

- (void)getPlaceName:(CLRegion *)placeName{
    //NSLog(@"placeName22 == %@",placeName.identifier);
    NSArray *tempArr = [placeName.identifier componentsSeparatedByString:@"+"];
    //NSLog(@"tempArr == %@",tempArr);
    NSString *latitude = [[[[[tempArr objectAtIndex:1] componentsSeparatedByString:@","] objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSString *longitude= [[[[[tempArr objectAtIndex:2] componentsSeparatedByString:@">"] objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    //NSLog(@"11%@",latitude);
    //NSLog(@"22%@",longitude);
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    [tempDic setObject:latitude forKey:@"latitude"];
    [tempDic setObject:longitude forKey:@"longitude"];
    NSArray *array = [[NSArray alloc] initWithObjects:tempDic, nil];
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
@end
