//
//  HAProviceCellTableViewCell.m
//  安心汽车
//
//  Created by 罗海波 on 15/3/25.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAProviceCellTableViewCell.h"
#import "HAViolationProvicePrameResult.h"
#import "HAViolationCitysParameResult.h"


@implementation HAProviceCellTableViewCell
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString * ID = @"PROVICE";
    HAProviceCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[HAProviceCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)setProvice:(HAViolationProvicePrameResult *)provice{
    _provice = provice;
    NSArray *citysArray = _cityNameArr;
    if (citysArray.count == 1) {
        //省份名和城市名相同
        if ([self.provice.province isEqualToString:[_cityNameArr objectAtIndex:0]]) {
            self.accessoryType = UITableViewCellAccessoryNone;
        }else{
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else{
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    self.textLabel.text = self.provice.province;
}

@end
