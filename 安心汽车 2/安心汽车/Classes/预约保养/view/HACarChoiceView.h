//
//  HACarChoiceView.h
//  安心汽车
//
//  Created by kongw on 15/5/4.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

@protocol carTypeChoiceDelegate <NSObject>

- (void)getLoveCarType:(NSString *)carName andCarType:(NSString *)tempCarType;
- (void)addMoreCar;

@end

#import <UIKit/UIKit.h>

@interface HACarChoiceView : UIImageView<UITableViewDataSource,UITableViewDelegate>{
    UITableView *loveTableView;
    NSArray *loveCarArr;
}

@property(nonatomic, strong) id<carTypeChoiceDelegate>delegate;
- (id)initWithFrame:(CGRect)frame andCarArr:(NSArray *)carArr;

@end
