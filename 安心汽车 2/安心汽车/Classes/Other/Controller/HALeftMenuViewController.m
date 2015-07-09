//
//  HALeftMenuViewController.m
//  安心汽车
//
//  Created by 孔伟 on 15/4/19.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HALeftMenuViewController.h"

@implementation HALeftMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"左侧边栏";
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bk"]];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    /*
     只在左侧边栏中做了返回主界面的处理,其他的类都是只返回到对应的侧边栏.
     大家如果有兴趣的话可以自己去测试 IIViewDeckController.h 这个类中的方法
     */
    leftArr = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
    leftTableView.backgroundColor = [UIColor clearColor];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    [self.view addSubview:leftTableView];
}

-(void)goToSubView{
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        self.view.userInteractionEnabled = YES;
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return leftArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 30)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = [leftArr objectAtIndex:indexPath.row];
        [cell addSubview:textLabel];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self goToSubView];
}
@end
