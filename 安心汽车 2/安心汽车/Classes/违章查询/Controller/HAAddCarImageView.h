//
//  HAAddCarImageView.h
//  安心汽车
//
//  Created by kongw on 15/3/25.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

@protocol HAAddCarDelegate <NSObject>

- (void)getNotifaCation;
- (void)deleteButtonAgainView:(UIButton *)sender;
- (void)addButtonAction:(UIButton *)sender;
- (void)deteleButtonAction:(UIButton *)sender;

@end

#import <UIKit/UIKit.h>
#import "HAListButton.h"

@interface HAAddCarImageView : UIImageView<UITextFieldDelegate,ListDelegate>{
    id<HAAddCarDelegate>delegate;
}
@property (nonatomic ,strong) id<HAAddCarDelegate>delegate;

- (id)initWithFrame:(CGRect)frame andAddCarInfoArr:(NSMutableArray *)carListInfoArr andEditor:(HAUserInputModel *)inputData andType:(NSInteger)type;
@end
