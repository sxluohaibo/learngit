//
//  HACenterView.h
//  安心汽车
//
//  Created by kongw on 15/3/19.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HACityView.h"
#import "HALoveCarModel.h"

@interface HACenterView : UIImageView<UIScrollViewDelegate>{
    
}
@property (nonatomic, retain) UIView *primaryView;
@property (nonatomic, retain) UIView *secondaryView;
@property float spinTime;

- (void)getCarNumber:(HALoveCarModel *)loveModel andServerTime:(NSString *)ServerTime;

@end
