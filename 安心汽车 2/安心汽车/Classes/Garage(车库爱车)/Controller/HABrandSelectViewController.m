//
//  HABrandSelectViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  品牌选择控制器

#import "HABrandSelectViewController.h"
#import "HACarSeriesViewController.h"
#import "AFNetworking.h"
#import "HACarBrand.h"
#import "HACarBrandGroup.h"
#import "MJExtension.h"
#import "FMDB.h"
@interface HABrandSelectViewController ()


/**车辆品牌组*/
@property(nonatomic,strong)NSMutableArray * carBrandGroups;

/**车辆品牌*/
@property(nonatomic,strong)NSArray * carBrands;

/**车辆品牌*/
@property(nonatomic,strong)NSArray * titleArray;




@property (nonatomic, strong) FMDatabaseQueue * dbqueue;

@end

@implementation HABrandSelectViewController
@synthesize type;



- (NSArray *)carBrands
{
    if (_carBrands == nil) {
        _carBrands = [NSArray array];
    }
    
    return _carBrands;
}

- (NSArray *)carBrandGroups
{
    if (_carBrandGroups == nil) {
        _carBrandGroups = [NSMutableArray array];
    
    }
    
    return _carBrandGroups;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择品牌";
    
    
   AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://file.ywsoftware.com:9090/T100040/carType/showCarBrands" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
        
        
        self.carBrands = [HACarBrand objectArrayWithKeyValuesArray:responseObject];
       

        HACarBrand * previous = nil;
        HACarBrandGroup * previousGroup = nil;
        for (HACarBrand * carBrand in self.carBrands) {
            
            //NSLog(@"%@  %@ %@",carBrand.brandId,carBrand.brandName,carBrand.firstLetter);
            if ([previous.firstLetter isEqualToString:carBrand.firstLetter]) {//一样
                
            
                previous = carBrand;
                
             
                [previousGroup.carBrands addObject:carBrand];
                
                
            }else{//不一样
                
                previous = carBrand;
                HACarBrandGroup * group = [[HACarBrandGroup alloc] init];
                
                group.firstLetter = carBrand.firstLetter;
                [group.carBrands addObject:carBrand];
                previousGroup = group;
                [self.carBrandGroups addObject:group];
                
                
            }
        }
      
 
        [self.tableView reloadData];
        
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"error:%@",error);
        }];
 
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
}

-(void)backAction:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)test
{
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [paths stringByAppendingPathComponent:@"LoveCar.db"];
    
    NSLog(@"%@",path);
    self.dbqueue = [FMDatabaseQueue databaseQueueWithPath:path];
    [self.dbqueue inDatabase:^(FMDatabase *db) {
        
        //数据库建表成功
        [db executeUpdate:@"create table if not exists t_carBrand (brandId integer primary key,brandName text,firstLetter text);"];
        
    }];
    
    
    __block FMResultSet * res = nil;
    
    [self.dbqueue inDatabase:^(FMDatabase *db) {
        
        res =  [db executeQuery:@"select count(*) from t_carBrand"];
        
    }];
    
}



#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.carBrandGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    HACarBrandGroup * group = self.carBrandGroups[section];

    return group.carBrands.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * ID = @"Brand";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = HAColor(23, 56, 84);
    }
    
//    cell.textLabel.text = @"dasdasdasd";
    HACarBrandGroup * group = self.carBrandGroups[indexPath.section];
    HACarBrand * brand = group.carBrands[indexPath.row];
    
//    HACarBrand * brand = self.carBrands[indexPath.row];
    cell.textLabel.text = brand.brandName;
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    HACarBrandGroup * group = self.carBrandGroups[section];
    return group.firstLetter;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *array = [NSMutableArray array];
    for (HACarBrandGroup * group in self.carBrandGroups) {
        
        [array addObject:group.firstLetter];
    }
    
    self.titleArray = array;
    return array;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HACarBrandGroup * group = self.carBrandGroups[indexPath.section];
    HACarBrand * brand = group.carBrands[indexPath.row];
    
    
    HACarSeriesViewController * boardVc = [[HACarSeriesViewController alloc] init];
    boardVc.carBrand = brand;
    boardVc.title = @"选择车系";
    [self.navigationController pushViewController:boardVc animated:YES];
    
}
@end
