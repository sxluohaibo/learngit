//
//  HAOilPiceView.m
//  安心汽车
//
//  Created by kongw on 15/3/20.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAOilPiceView.h"
#import <QuartzCore/QuartzCore.h>

@implementation HAOilPiceView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *oilName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        oilName.textAlignment = NSTextAlignmentLeft;
        oilName.tag = 88;
        oilName.textColor = [UIColor whiteColor];
        oilName.text = @"今日油价";
        [self addSubview:oilName];
        
        for (int i = 0; i < 4; i++) {
            UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(i*80, 40, 60, 80)];
            iconImage.layer.masksToBounds = YES;
            iconImage.layer.cornerRadius = 6.0;
            iconImage.layer.borderWidth = 1.0;
            iconImage.layer.borderColor = [[UIColor whiteColor] CGColor];
            iconImage.backgroundColor = RGBACOLOR(158,205,232,1);
            [self addSubview:iconImage];
            
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            title.textColor = [UIColor blackColor];
            title.textAlignment = NSTextAlignmentCenter;
            if (i == 0) {
                title.text = @"90 #";
            }else if (i==1){
                title.text = @"93 #";
            }else if (i==2){
                title.text = @"95 #";
            }else if (i==3){
                title.text = @"0 #";
            }
            [iconImage addSubview:title];
            
            UILabel *titlePrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 30)];
            titlePrice.layer.masksToBounds = YES;
            titlePrice.layer.cornerRadius = 6.0;
            titlePrice.backgroundColor = [UIColor clearColor];
            titlePrice.textColor = [UIColor whiteColor];
            titlePrice.textAlignment = NSTextAlignmentCenter;
            titlePrice.text = @"";
            [iconImage addSubview:titlePrice];
            
        }
    }
    return self;
}

- (void)initOilView:(NSDictionary *)tempDic{
    NSDictionary *oilDic = tempDic;
    NSArray *oilArr = [[NSArray alloc] initWithObjects:[oilDic objectForKey:@"b90"],[oilDic objectForKey:@"b93"],[oilDic objectForKey:@"b97"],[oilDic objectForKey:@"b0"], nil];
    for (int i = 0; i < 4; i++) {
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(i*80, 40, 60, 80)];
        iconImage.layer.masksToBounds = YES;
        iconImage.layer.cornerRadius = 6.0;
        iconImage.layer.borderWidth = 1.0;
        iconImage.layer.borderColor = [[UIColor whiteColor] CGColor];
        iconImage.backgroundColor = RGBACOLOR(158,205,232,1);
        [self addSubview:iconImage];
        
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        title.textColor = [UIColor blackColor];
        title.textAlignment = NSTextAlignmentCenter;
        NSString *tempStr = [oilArr objectAtIndex:i];
        if (i == 0) {
            if ([[tempDic objectForKey:@"city"] isEqualToString:@"上海"] || [[tempDic objectForKey:@"city"] isEqualToString:@"北京"]) {
                title.text = @"89 #";
            }else{
                title.text = @"90 #";
            }
        }else if (i==1){
            if ([[tempDic objectForKey:@"city"] isEqualToString:@"上海"] || [[tempDic objectForKey:@"city"] isEqualToString:@"北京"]) {
                title.text = @"92 #";
            }else{
                title.text = @"93 #";
            }
        }else if (i==2){
            if ([[tempDic objectForKey:@"city"] isEqualToString:@"上海"] || [[tempDic objectForKey:@"city"] isEqualToString:@"北京"]) {
                title.text = @"95 #";
            }else{
                title.text = @"97 #";
            }
        }else if (i==3){
            title.text = @"0 #";
        }
        [iconImage addSubview:title];
        
        UILabel *titlePrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 30)];
        titlePrice.layer.masksToBounds = YES;
        titlePrice.layer.cornerRadius = 6.0;
        titlePrice.backgroundColor = [UIColor clearColor];
        titlePrice.textColor = [UIColor whiteColor];
        titlePrice.textAlignment = NSTextAlignmentCenter;
        if ([HAManger HAReplaceString:tempStr excuseString:@"："]) {
            //NSLog(@"dfgg == %@",[oilArr objectAtIndex:i]);
            NSArray *array = [tempStr componentsSeparatedByString:@"："];
            titlePrice.text = [array objectAtIndex:1];
        }else{
            titlePrice.text = tempStr;
        }
        [iconImage addSubview:titlePrice];
    }
}

@end
