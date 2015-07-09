//
//  HACarChoiceView.m
//  安心汽车
//
//  Created by kongw on 15/5/4.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACarChoiceView.h"
#import "HALoveCarModel.h"

@implementation HACarChoiceView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame andCarArr:(NSArray *)carArr{
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = YES;
    if (self) {
        loveCarArr = carArr;
        //(10, 18, 142, 18) 显示我的爱车列表
        loveTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 142, frame.size.height)];
        loveTableView.backgroundColor = [UIColor clearColor];
        loveTableView.scrollEnabled = YES;
        loveTableView.userInteractionEnabled = YES;
        loveTableView.delegate = self;
        loveTableView.dataSource = self;
        [self addSubview:loveTableView];
        
        UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, loveTableView.bounds.size.width, 44.0f)];
        loveTableView.tableFooterView = tableFooterView;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor grayColor]];
        button.frame = CGRectMake(0, 0, 142, 44);
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [button setTitleColor:HAColor(47, 92, 143) forState:UIControlStateNormal];
        button.titleLabel.textColor = HAColor(47, 92, 143);
        [button setTitle:@"添加更多车辆" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addCarAction) forControlEvents:UIControlEventTouchUpInside];
        [tableFooterView addSubview:button];
    }
    return self;
}

//跳转到我的爱车
- (void)addCarAction{
    [delegate addMoreCar];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return loveCarArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    HALoveCarModel * loveCar = (HALoveCarModel *)[loveCarArr objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.textColor = HAColor(47, 92, 143);
    cell.textLabel.text = [NSString stringWithFormat:@"%@",loveCar.carNumber];
    cell.accessibilityIdentifier = loveCar.carType;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    NSString *currentCityName = cell.textLabel.text;
    [delegate getLoveCarType:currentCityName andCarType:cell.accessibilityIdentifier];
}
@end
