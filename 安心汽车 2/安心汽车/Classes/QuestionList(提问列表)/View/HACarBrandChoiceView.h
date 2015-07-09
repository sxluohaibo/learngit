//
//  HACarBrandChoiceView.h
//  安心汽车
//
//  Created by un2lock on 15/5/11.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

@class HACarBrandChoiceView;
@protocol carBrandChoiceDelegate <NSObject>

- (void)getLoveCarType:(NSString *)carName andCarType:(NSString *)tempCarType;
- (void)clickCarBrand:(HACarBrandChoiceView *)view currentCarBrandText:(NSString *)currentCarBrandText;

@end

#import <UIKit/UIKit.h>

@interface HACarBrandChoiceView :UIImageView<UITableViewDataSource,UITableViewDelegate>{
    UITableView *loveTableView;
    NSArray *loveCarArr;
    
}
@property(nonatomic,assign) BOOL isShow;
@property(nonatomic, strong) id<carBrandChoiceDelegate>delegate;
- (id)initWithFrame:(CGRect)frame andCarArr:(NSArray *)carArr;
@end
