//
//  HAChoiceVioViewController.m
//  安心汽车
//
//  Created by kongw on 15/3/24.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAChoiceVioViewController.h"
#import "HABaseAnxin.h"
#import "HABeanprovince.h"
#import "HABeancity.h"

@interface HAChoiceVioViewController ()

@end

@implementation HAChoiceVioViewController
@synthesize choiceListArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择城市列表";
    [self setupNav];
    proviceAndCitys = [[NSArray alloc] init];
    
    choiceViolationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    choiceViolationTableView.backgroundColor = [UIColor clearColor];
    choiceViolationTableView.delegate = self;
    choiceViolationTableView.dataSource = self;
    [self.view addSubview:choiceViolationTableView];
    

    if ([[HABeanprovince shareBeanProvince] isProViceArr]) {//本地有数据 就去本地的数据
        proviceAndCitys = [[HABeanprovince shareBeanProvince] getProvinceArr];
        [choiceViolationTableView reloadData];
    }else{
        //http://172.16.10.18:8080/T100040/citys.js
        NSString *downName = [NSString stringWithFormat:@"T100040/citys.js"];
        MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:nil httpMethod:@"GET" ssl:NO];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
            //获取数据
            proviceAndCitys = [HAManger ParseProviceResultData:cityInfo];
            for (int i = 0; i < proviceAndCitys.count; i++) {
                HAViolationProvicePrameResult *tempData = [proviceAndCitys objectAtIndex:i];
                [[HABeanprovince shareBeanProvince] addProvinceData:tempData];//省插入数据库
                for (int j = 0; j < tempData.citys.count; j++) {
                    HAViolationCitysParameResult *tempCity = (HAViolationCitysParameResult *)[tempData.citys objectAtIndex:j];
                    [[HABeancity shareBeanCity] addCityData:tempCity];//市插入数据库
                }
            }
            //刷新界面
            [choiceViolationTableView reloadData];
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"失败");
        }];
        [ApplicationDelegate.engine enqueueOperation:op];
    }
}


/**
 *  设置导航栏
 */
-(void)setupNav{
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
}
/**
 *  点击返回按钮,返回到首界面
 */
-(void)backAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return proviceAndCitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HAViolationProvicePrameResult * provice = proviceAndCitys[indexPath.row];
    HAProviceCellTableViewCell * cell =  [HAProviceCellTableViewCell cellWithTableView:tableView];
    cell.accessibilityHint = provice.province_code;
    cell.cityNameArr = [[HABeancity shareBeanCity] readCityfrom:[NSString stringWithFormat:@"\'%@\'",provice.province_code]];
    cell.provice = provice;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    HAViolationProvicePrameResult * provice = proviceAndCitys[indexPath.row];//省份
    HAVSecondViewController *secondVc = [[HAVSecondViewController alloc] init];
    secondVc.choiceListArr = choiceListArr;
    secondVc.cityArr = [[HABeancity shareBeanCity] readCityfrom:[NSString stringWithFormat:@"\'%@\'",cell.accessibilityHint]];
    BOOL isSame = [[secondVc.cityArr objectAtIndex:0] isEqualToString:provice.province];
    
    //数组的数量大于5就不允许添加
    if (choiceListArr.count>4) {
        [MBProgressHUD showError:@"只能添加5个城市"];
        return;
    }
    
    for (int i = 0; i < choiceListArr.count; i++) {
        HAViolationCitysParameResult *cityModel = [choiceListArr objectAtIndex:i];
        if ([cityModel.city_name isEqualToString:provice.province]) {
            [MBProgressHUD showError:@"城市已经添加"];
            return;
        }
    }
    if (isSame && secondVc.cityArr.count == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ClickViolationName object:[secondVc.cityArr objectAtIndex:0]];
        [self dismissViewControllerAnimated:YES completion:^{//传city过去
            //存储用户选择的城市
            [[NSNotificationCenter defaultCenter] removeObserver:self name:ClickViolationName object:nil];
        }];
    }else{
        [self.navigationController pushViewController:secondVc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
