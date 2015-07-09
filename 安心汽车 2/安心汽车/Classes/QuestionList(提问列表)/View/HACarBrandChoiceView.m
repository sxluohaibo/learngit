//
//  HACarBrandChoiceView.m
//  安心汽车
//
//  Created by un2lock on 15/5/11.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACarBrandChoiceView.h"
#import "HALoveCarModel.h"

@implementation HACarBrandChoiceView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame andCarArr:(NSArray *)carArr{
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = YES;
    if (self) {
        loveCarArr = carArr;
        loveTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        loveTableView.backgroundColor=[UIColor whiteColor];
        loveTableView.delegate = self;
        loveTableView.dataSource = self;
        [self addSubview:loveTableView];
    }
    return self;
}

//跳转到我的爱车
- (void)addCarAction{
//    [delegate addMoreCar];
    
}

#pragma mark - UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

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
    cell.textLabel.font = [UIFont systemFontOfSize:11.0f];
    cell.textLabel.textColor = HAColor(47, 92, 143);
    cell.textLabel.text = [NSString stringWithFormat:@"%@",loveCar.carNumber];
    cell.accessibilityIdentifier = loveCar.carNumber;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    NSString *currentCarBrandText = cell.textLabel.text;
    [delegate clickCarBrand:self currentCarBrandText:currentCarBrandText];
}


@end
