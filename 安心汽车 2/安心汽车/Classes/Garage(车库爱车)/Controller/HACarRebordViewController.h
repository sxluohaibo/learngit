//
//  HACarRebordViewController.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HALoveCarModel;


@protocol HACarRebordViewControllerdelegate<NSObject>

@optional

/**数据库中车辆信息修改了*/
-(void)CarRebordViewControllerToLoadNewDate;

- (void)deleteLoveCarInfoButtonClick;

@end

@interface HACarRebordViewController : HAWindowViewController



@property(nonatomic,strong)HALoveCarModel * loveCarMessage;


@property(nonatomic,weak)id<HACarRebordViewControllerdelegate>delegate;

@end
