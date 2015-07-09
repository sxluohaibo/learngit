//
//  HACityHostListCell.m
//  安心汽车
//
//  Created by un2lock on 15/3/19.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACityHostListCell.h"
#import "HACityViewController.h"
#import "HANavigationController.h"
#define kAppViewW 107
#define kAppViewH 40
#define kColCount 3
#define kStartY   0

@interface HACityHostListCell()
@property(nonatomic,retain) NSArray *arrays;
@end
@implementation HACityHostListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //初始化数组
    _arrays = [[NSMutableArray alloc] init];
    _arrays=@[@"北京市",@"上海市",@"成都市",@"深圳市",@"重庆市",@"广州市",@"南京市",@"西安市",@"杭州市"];
    
    if(self){//初始化子控件
        CGFloat width=[UIScreen mainScreen].bounds.size.width;
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, kAppViewH*3)];
        
        for (int i = 0; i < 9; i++) {
            // 行
            // 0, 1, 2 => 0
            // 3, 4, 5 => 1
            int row = i / kColCount;
            
            // 列
            // 0, 3, 6 => 0
            // 1, 4, 7 => 1
            // 2, 5, 8 => 2
            int col = i % kColCount;
            CGFloat x=col *kAppViewW;
            CGFloat y =row*kAppViewH;
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, kAppViewW-1, kAppViewH-1)];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            [button setTitle:[_arrays objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitle:[_arrays objectAtIndex:i] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(cityClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.5]] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:0.5]] forState:UIControlStateHighlighted];
            
            [view addSubview:button];
        }
        
        //        [self setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.5]];
        [self.contentView addSubview:view];
    }
    return self;
}

/**
 *  存储点击时的Title名称
 */
-(void) cityClick:(UIButton *) button{
    //回到主界面
    //点击Cell上的按钮，隐藏界面
    HACityViewController *controller=(HACityViewController *)[self.superview viewController];
    [controller dismissViewControllerAnimated:YES completion:^{
        [[NSUserDefaults standardUserDefaults]  setObject:[button currentTitle] forKey:dwCityName];
        [[NSNotificationCenter  defaultCenter] postNotificationName:ClickHotCityName object:[button currentTitle]];
    }];
}
@end
