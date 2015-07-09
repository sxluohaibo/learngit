//
//  HANumberViewController.m
//  安心汽车
//
//  Created by un2lock on 15/3/25.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HANumberViewController.h"
#import "UIView+Extension.h"

@interface HANumberViewController()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSMutableArray *BaoXianArrays;
@property(nonatomic,strong) NSMutableArray *ChuXianArrays;
@property(nonatomic,strong) UISegmentedControl *control;
@end

@implementation HANumberViewController
/**
 *  设置选项卡
 */
-(void)setupChooseBar{
    NSMutableArray *items=[NSMutableArray array];
    [items addObject:@"出险电话"];
    [items addObject:@"紧急拔号"];
    _control=[[UISegmentedControl alloc] initWithItems:items];
    [_control addTarget:self action:@selector(chooseIndex:) forControlEvents:UIControlEventValueChanged];
    _control.selectedSegmentIndex=0;
    self.navigationItem.titleView=_control;
}
/**
 *  给ScrollView设置哪一个界面显示
 */
-(void)chooseIndex:(UISegmentedControl *)control{
    NSInteger selectIndex=[control selectedSegmentIndex];
    tableview.tag = selectIndex;
    [tableview reloadData];
    NSLog(@"selectIndex == %ld",(long)selectIndex);
}
// 视图加载完成调用，通常用来设置数据
- (void)viewDidLoad{
    [super viewDidLoad];
    [self readPlist];  //读取文件
    [self setupChooseBar];
    [self setTableView];
}
/**
 *  设置tabview界面
 */
-(void)setTableView{
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
}

#pragma mark 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView.tag==0){
        return self.BaoXianArrays.count;
    }else{
        return self.ChuXianArrays.count;
    }
}
/**
 *  设置每一个cell的内容
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag==0){
        static NSString *ID=@"cell1";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        if(cell==nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        NSArray *array=[self.BaoXianArrays objectAtIndex:indexPath.row];
        cell.textLabel.text=[array objectAtIndex:0];
        cell.detailTextLabel.text=[array objectAtIndex:1];
        UIButton *rightButton=[self addRightButton:cell];
        cell.accessoryView=rightButton;
        return cell;
    }else{
        static NSString *ID=@"cell2";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        if(cell==nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        NSArray *array=[self.ChuXianArrays objectAtIndex:indexPath.row];
        cell.textLabel.text=[array objectAtIndex:0];
        cell.detailTextLabel.text=[array objectAtIndex:1];
        UIButton *rightButton=[self addRightButton:cell];
        cell.accessoryView=rightButton;
        return cell;
    }
}
-(UIButton *) addRightButton:(UITableViewCell *)cell{
    UIButton *rightButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    NSString *phoneNumber=cell.detailTextLabel.text;
    rightButton.tag=[phoneNumber integerValue];  //将当前电话赋值给按钮的tag
    [rightButton setImage:[UIImage imageNamed:@"call_ico"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    return rightButton;
}
/**
 *  点击按钮拔打电话
 */
-(void)callPhone:(UIButton *) button{
    NSString *number=[NSString stringWithFormat:@"%ld",(long)button.tag];
    NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
}
/**
 *  读取pList文件
 */
-(void) readPlist{
    NSString *BaoXianplistPath = [[NSBundle mainBundle] pathForResource:@"BaoXian" ofType:@"plist"];
    self.BaoXianArrays = [[NSMutableArray alloc] initWithContentsOfFile:BaoXianplistPath];
    NSString *ChuXianplistPath = [[NSBundle mainBundle] pathForResource:@"ChuXian" ofType:@"plist"];
    self.ChuXianArrays = [[NSMutableArray alloc] initWithContentsOfFile:ChuXianplistPath];
}
@end
