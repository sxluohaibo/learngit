//
//  HACenterView.m
//  安心汽车
//
//  Created by kongw on 15/3/19.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACenterView.h"

@implementation HACenterView{
    UILabel *carTypeNumber;
    BOOL displayingPrimary;//控制翻转
    UIImageView *cornerImageView;//车牌背景
    UIButton *nextTime;//下次保养时间
}
@synthesize primaryView;
@synthesize secondaryView;
@synthesize spinTime;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        displayingPrimary = YES;
        spinTime = 1.0;
    }
    return self;
}

//得到车牌号
- (void)getCarNumber:(HALoveCarModel *)loveModel andServerTime:(NSString *)ServerTime{
    [HAManger getBaoYangTime:loveModel.serverTime];
    if (loveModel.carNumber) {
        carTypeNumber.text = [NSString stringWithFormat:@"%@",loveModel.carNumber];
    }else{
        carTypeNumber.text = @"";
    }
    if (loveModel.serverTime) {
        [nextTime removeTarget:self action:@selector(nextTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        [nextTime setTitle:[NSString stringWithFormat:@"下次保养的时间:%@",[HAManger getBaoYangTime:ServerTime]] forState:UIControlStateNormal];
    }else{
        [nextTime addTarget:self action:@selector(nextTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        [nextTime setTitle:@"请您到我的爱车添加预约时间" forState:UIControlStateNormal];
    }
}

//跳转到我的爱车
- (void)nextTimeAction:(UIButton *)sender{
    NSLog(@"我的爱车");
    HALoveCarViewController *loveVc = [[HALoveCarViewController alloc] init];
    [[self viewController].navigationController pushViewController:loveVc animated:YES];
}

//初始化第一个视图
- (void)setPrimaryView:(UIView *)tempView{
    primaryView = tempView;
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.primaryView setFrame:frame];
    self.primaryView.userInteractionEnabled = YES;
    [self addSubview: self.primaryView];
    //UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipTouched:)];
    //gesture.numberOfTapsRequired = 1;
    //[self.primaryView addGestureRecognizer:gesture];
    self.primaryView.backgroundColor = [UIColor clearColor];
    
    //初始化第一个界面的数据
    cornerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (self.primaryView.frame.size.height-180)/2, frame.size.width-40, 180)];
    cornerImageView.userInteractionEnabled = YES;
    cornerImageView.backgroundColor = [UIColor clearColor];
    [primaryView addSubview:cornerImageView];
    
    UIImageView *carTypeBk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cornerImageView.frame.size.width, 100)];
    carTypeBk.userInteractionEnabled = YES;
    carTypeBk.backgroundColor = HAColor(64, 83, 106);
    carTypeBk.layer.cornerRadius = 6.0;
    carTypeBk.layer.masksToBounds = YES;
    [cornerImageView addSubview:carTypeBk];
    
    carTypeNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cornerImageView.frame.size.width, 30)];
    carTypeNumber.textAlignment = NSTextAlignmentCenter;
    carTypeNumber.textColor = [UIColor whiteColor];
    carTypeNumber.text = [NSString stringWithFormat:@"%@",@""];
    carTypeNumber.font = [UIFont systemFontOfSize:16.0f];
    carTypeNumber.backgroundColor = HAColor(49, 73, 120);
    [carTypeBk addSubview:carTypeNumber];
    
    UIImageView *nextImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, cornerImageView.frame.size.width, 70)];
    nextImage.userInteractionEnabled = YES;
    nextImage.backgroundColor = HAColor(233, 233, 237);
    [carTypeBk addSubview:nextImage];
    
    nextTime = [UIButton buttonWithType:UIButtonTypeCustom];
    nextTime.frame = CGRectMake(0, 20, cornerImageView.frame.size.width, 20);
    nextTime.titleLabel.textAlignment = NSTextAlignmentCenter;
    nextTime.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [nextTime setTitleColor:HAColor(43, 67, 92) forState:UIControlStateNormal];
    [nextImage addSubview:nextTime];
}

//初始化第二个视图
- (void)setSecondaryView:(UIView *)tempView{
    secondaryView = tempView;
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.secondaryView setFrame: frame];
    self.secondaryView.userInteractionEnabled = YES;
    [self addSubview: self.secondaryView];
    [self sendSubviewToBack:self.secondaryView];
    
    //UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipTouched:)];
    //gesture.numberOfTapsRequired = 1;
    //[self.secondaryView addGestureRecognizer:gesture];
    //初始化第二个界面的数据
}

//增加爱车列表
- (void)addButtonAction:(UIButton *)sender{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]) {
        HALoveCarViewController *loveVc = [[HALoveCarViewController alloc] init];
        HANavigationController *navigationVC=[[HANavigationController alloc] initWithRootViewController:loveVc];
        [[self viewController] presentViewController:navigationVC animated:YES completion:^{
            
        }];
    }else{
        HALoginViewController *loginVc = [[HALoginViewController alloc] init];
        [[self viewController].navigationController pushViewController:loginVc animated:YES];
    }
}
/*
-(IBAction)flipTouched:(id)sender{
    self.secondaryView.backgroundColor = [UIColor whiteColor];//旋转的时候给设置一个背景颜色
    [UIView transitionFromView:(displayingPrimary ? self.primaryView : self.secondaryView)
                        toView:(displayingPrimary ? self.secondaryView : self.primaryView)
                      duration: spinTime
                       options: UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut
                    completion:^(BOOL finished) {
                        if (finished) {
                            displayingPrimary = !displayingPrimary;
                        }
                    }
     ];
}*/

@end
