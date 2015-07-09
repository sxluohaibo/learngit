//
//  HAListButton.h
//  安心汽车
//
//  Created by kongw on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

@protocol ListDelegate <NSObject>

- (void)deleteRefreshView:(UIButton *)sender;//删除数据刷新界面

@end

#import <UIKit/UIKit.h>
@interface HAListButton : UIButton{
    
}
@property (nonatomic, strong) id <ListDelegate>delegate;

- (id)initWithFrame:(CGRect)frame;
- (void)buttonListArr:(NSArray *)listArr;

@end
