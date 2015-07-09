//
//  HAViolationViewController.m
//  安心汽车
//
//  Created by kongw on 15/3/20.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAViolationViewController.h"

@interface HAViolationViewController (){
    UIImageView *addView;
}
@end

@implementation HAViolationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"违章查询";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sub_bg.jpg"]];
    violationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    violationTableView.backgroundColor = [UIColor clearColor];
    violationTableView.delegate = self;
    violationTableView.dataSource = self;
    [self.view addSubview:violationTableView];
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, violationTableView.bounds.size.width, 55.0f)];
    violationTableView.tableFooterView = tableFooterView;
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(17, (55-24)/2, 24, 24)];
    iconImage.image = [UIImage imageNamed:@"add_new_icon"];
    [tableFooterView addSubview:iconImage];
    
    UIImageView *linebk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 54.5, ScreenWidth, 0.5)];
    linebk.backgroundColor = [UIColor grayColor];
    linebk.alpha = 0.5;
    [tableFooterView addSubview:linebk];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0, 21, ScreenWidth, 12);
    addButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [addButton setTitle:@"添加新的查询车辆" forState:UIControlStateNormal];
    [addButton setTitleColor:HAColor(88, 113, 140) forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addCarInfo:) forControlEvents:UIControlEventTouchUpInside];
    [tableFooterView addSubview:addButton];
    
    
    addView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-139)/2, 108, 139, 96)];
    addView.image = [UIImage imageNamed:@"cxcl_bar"];
    addView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCarInfo:)];
    [addView addGestureRecognizer:tap];
    [self.view addSubview:addView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    userInputInfoArr = [[HABeanUserInput shareUserInput] getUserInputArr:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]];//得到数据
    vioInfoArr = [ApplicationDelegate.store getAllItemsFromTable:VioResultDB];
    if (userInputInfoArr.count == 0) {
        addView.hidden = NO;
        violationTableView.hidden = YES;
    }else{
        [violationTableView reloadData];
        addView.hidden = YES;
        violationTableView.hidden = NO;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return userInputInfoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        HAUserInputModel *userInput = [userInputInfoArr objectAtIndex:indexPath.row];
        NSLog(@"剩下的车牌号码车牌号码 ＝＝ %@",userInput.carTypeNumber);
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(17, 15, 33, 23)];
        iconImage.image = [UIImage imageNamed:@"car_icon"];
        [cell addSubview:iconImage];
        cell.accessibilityHint = userInput.carTypeNumber;//车牌号
        cell.accessibilityIdentifier = userInput.vioArea;//违章区域
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(80, 12, 200, 10)];
        title.backgroundColor = [UIColor clearColor];
        title.textColor = HAColor(88, 113, 140);
        title.font = [UIFont systemFontOfSize:14.f];
        title.text = userInput.carTypeNumber;
        [cell addSubview:title];
        
        YTKKeyValueItem *itemVio = (YTKKeyValueItem *)[vioInfoArr objectAtIndex:indexPath.row];
        NSDictionary *dicVio = itemVio.itemObject;
        if ([[dicVio objectForKey:@"resultcode"] integerValue] == 200) {
            NSArray *listArr = [[dicVio objectForKey:@"result"] objectForKey:@"lists"];
            UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(80, 28, 220, 12)];
            description.backgroundColor = [UIColor clearColor];
            description.font = [UIFont systemFontOfSize:12.0f];
            description.textColor = HAColor(88, 113, 140);
            if (listArr.count == 0) {
                description.text = @"您没有违章信息";
            }else{
                description.text = [NSString stringWithFormat:@"您现在有%lu条违章",(unsigned long)listArr.count];
            }
            [cell addSubview:description];
        }

        UIImageView *linebk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 54.5, ScreenWidth, 0.5)];
        linebk.backgroundColor = [UIColor grayColor];
        linebk.alpha = 0.5;
        [cell addSubview:linebk];
        
        UIButton *editor = [UIButton buttonWithType:UIButtonTypeCustom];
        editor.frame = CGRectMake(ScreenWidth-40, 20, 16, 16);
        editor.accessibilityHint = userInput.carTypeNumber;//车牌号
        editor.accessibilityIdentifier = userInput.vioArea;//违章区域
        [editor addTarget:self action:@selector(editorAction:) forControlEvents:UIControlEventTouchUpInside];
        [editor setImage:[UIImage imageNamed:@"car_edit_icon"] forState:UIControlStateNormal];
        [cell addSubview:editor];
    }
    return cell;
}

//编辑按钮
- (void)editorAction:(UIButton *)sender{
    HAAddCarViewController *addCarVc = [[HAAddCarViewController alloc] init];
    addCarVc.delegate = self;
    NSLog(@"车牌号 == %@",sender.accessibilityHint);
    NSLog(@"违章区域 == %@",sender.accessibilityIdentifier);
    //数据库查询 获得城市需要数据 绘制界面
    HAViolationCitysParameResult *cityModel = [[HABeancity shareBeanCity] checkOneCityData:sender.accessibilityIdentifier];
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    [tempArr addObject:cityModel];
    addCarVc.userInput = [[HABeanUserInput shareUserInput] getUserInfoData:sender.accessibilityHint];
    addCarVc.totalArr = tempArr;
    [self.navigationController pushViewController:addCarVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (void)addCarInfo:(UIButton *)sender{
    HAAddCarViewController *addCarVc = [[HAAddCarViewController alloc] init];
    addCarVc.delegate = self;
    addCarVc.type = 1;//增加车辆
    [self.navigationController pushViewController:addCarVc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HAViolationListViewController *listVC = [[HAViolationListViewController alloc] init];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    listVC.carType = cell.accessibilityHint;
    listVC.vioArea = cell.accessibilityIdentifier;
    [self.navigationController pushViewController:listVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)getMoney:(NSInteger)index andArr:(NSArray *)tempArr{
    NSInteger money = 0;
    NSInteger fen = 0;
    for (int j= 0; j < tempArr.count; j++) {
        NSDictionary *temp = [tempArr objectAtIndex:j];
        NSInteger tempMoney = [[temp objectForKey:@"money"] integerValue];
        NSInteger tempFen = [[temp objectForKey:@"fen"] integerValue];
        money += tempMoney;
        fen += tempFen;
    }
    return [NSString stringWithFormat:@"%ld-%ld",(long)money,(long)fen];
}

- (void)addCarMessageToMemmary{
    //刷新界面的数据
    userInputInfoArr = [[HABeanUserInput shareUserInput] getUserInputArr:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]];
    vioInfoArr = [ApplicationDelegate.store getAllItemsFromTable:VioResultDB];
}

@end
