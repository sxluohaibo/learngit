//
//  HAAddCarViewController.h
//  安心汽车
//
//  Created by kongw on 15/3/20.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HABaseSettingViewController.h"
#import "HAAddCarImageView.h"

@protocol HAAddCarViewControllerDelegate <NSObject>
@optional
/**保存车辆信息到本地的代理方法*/
-(void)addCarMessageToMemmary;
@end


@interface HAAddCarViewController : HAWindowViewController<HAAddCarDelegate>{
    NSMutableArray *totalArr;//全部的数据（最多5个）
    NSString *titleValue;
}

@property(nonatomic, strong) NSMutableArray *totalArr;//画界面的数组
@property(nonatomic, strong) HAUserInputModel *userInput;//编辑的时候修改数组
@property(nonatomic, strong) id<HAAddCarViewControllerDelegate>delegate;
@property(assign) NSInteger type;//1是增加车辆 2是修改车辆
@end
