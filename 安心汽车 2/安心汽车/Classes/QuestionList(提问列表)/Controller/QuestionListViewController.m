//
//  QuestionListViewController.m
//  提问列表demo1
//
//  Created by un2lock on 15/4/22.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "QuestionListViewController.h"
#import "QuestionListModel.h"
#import "QuestionModel.h"
#import "QuestionDetailViewController.h"
#import "QuestionAddViewController.h"
#import "HAQuestionCell.h"
#import "QuestionModelFrame.h"
#import "QuestionSubmitViewController.h"
#import "MJRefresh.h"

@interface QuestionListViewController()
@property(nonatomic,strong) AFHTTPRequestOperationManager *mrg;
/**提问列表集合*/
@property(nonatomic,strong) NSMutableArray *questionList;
@property (nonatomic, strong) NSMutableArray *questionFrames;
/** 添加信息的UIView*/
@property (nonatomic, strong) UIView *submitView;
@property(nonatomic,weak) UIButton *cover;
@property(nonatomic,assign) BOOL isRefresh;
/**是否正在添加*/
@property(nonatomic,assign) BOOL isShow;
@end

@implementation QuestionListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *questionBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    UIImage *addIcon=[UIImage imageNamed:@"add_icon"];
    [questionBtn setBackgroundImage:addIcon forState:UIControlStateNormal];
    [questionBtn addTarget:self action:@selector(questionAddClick:) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:questionBtn];
    
    self.navigationItem.title=@"咨询服务";
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(backto) image:@"back" highImage:@"back"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCarBrand:) name:@"addCarBrand" object:nil];
        
    NSString *isFirstSubmitQuestion=[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstSubmitQuestion"];
    if(![@"1" isEqualToString:isFirstSubmitQuestion]){
        //遮罩
        UIButton *firstCover=[[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        firstCover.backgroundColor=[UIColor clearColor];
        //中间背景
        UIImageView *backImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight -64)];
        [backImageView setImage:[UIImage imageNamed:@"sub_bg.jpg"]];
        
        [firstCover addSubview:backImageView];
        CGFloat centerImageW=130;
        CGFloat centerImageH=120;
        CGFloat centerImageX=(ScreenWidth - centerImageW) /2;
        CGFloat centerImageY=(ScreenHeight -centerImageH) /2-100;
        //中间的图片
        UIImageView *centerImage=[[UIImageView alloc] initWithFrame:CGRectMake(centerImageX, centerImageY, centerImageW, centerImageH)];
        centerImage.image=[UIImage imageNamed:@"warning_icon"];
        [firstCover addSubview:centerImage];
        
        CGSize label1Size=[self sizeWithText:@" 您还没有添加咨询哦 ! " font:[UIFont systemFontOfSize:24.0]];
        CGFloat label1Y=CGRectGetMaxY(centerImage.frame) + 35;
        CGFloat label1X=(ScreenWidth-label1Size.width)/2;
        UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(label1X, label1Y, label1Size.width, label1Size.height)];
        label1.text=@"您还没有添加咨询哦 !";
        label1.textColor=HAColor(211, 211, 211);
        label1.font=[UIFont systemFontOfSize:24.0];
        [firstCover addSubview:label1];
        
        CGSize label2Size=[self sizeWithText:@" 点击 \" + \" 发布关于汽车的咨询问题 " font:[UIFont systemFontOfSize:17.0]];
        CGFloat label2Y=CGRectGetMaxY(label1.frame) + 35;
        CGFloat label2X=(ScreenWidth-label2Size.width)/2;
        UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(label2X, label2Y, label2Size.width, label2Size.height)];
        label2.text=@" 点击 \" + \" 发布关于汽车的咨询问题 ";
        label2.textColor=HAColor(211, 211, 211);
        label2.font=[UIFont systemFontOfSize:17.0];
        [firstCover addSubview:label2];
        
        CGSize label3Size=[self sizeWithText:@" 您将于第一时间得到我们权威专家的回答 " font:[UIFont systemFontOfSize:17.0]];
        CGFloat label3Y=CGRectGetMaxY(label2.frame) + 15;
        CGFloat label3X=(ScreenWidth-label3Size.width)/2;
        UILabel *label3=[[UILabel alloc] initWithFrame:CGRectMake(label3X, label3Y, label3Size.width, label3Size.height)];
        label3.text=@" 您将于第一时间得到我们权威专家的回答 ";
        label3.textColor=HAColor(211, 211, 211);
        label3.font=[UIFont systemFontOfSize:17.0];
        [firstCover addSubview:label3];
        
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [window addSubview:firstCover];
        [firstCover addTarget:self action:@selector(firstCoverClick:) forControlEvents:UIControlEventTouchUpInside];
        self.tableView.hidden=YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isFirstSubmitQuestion"];
    }else{
        [self setRefresh];
        self.tableView.rowHeight=80;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        if (!_questionFrames) {
            self.questionFrames = [NSMutableArray array];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeCover:) name:ClickSubmitBtnToNet object:nil];
        self.tableView.hidden=NO;
        [self initData];
        [self getData];
    }
}
-(void) backto{
    if(_isShow==YES){
        [self dismissCover:_cover];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/**选择车型*/
-(void) addCarBrand:(NSNotificationCenter *)center{
    
    HALoveCarViewController *loveVc = [[HALoveCarViewController alloc] init];
    HANavigationController *navigationVC=[[HANavigationController alloc] initWithRootViewController:loveVc];
    [self presentViewController:navigationVC animated:YES completion:^{
        
    }];
}


- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, 0);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:0];
}
-(void) firstCoverClick:(UIButton *)sender{
    [sender removeFromSuperview];
    [self setRefresh];
    self.tableView.rowHeight=80;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    if (!_questionFrames) {
        self.questionFrames = [NSMutableArray array];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeCover:) name:ClickSubmitBtnToNet object:nil];
    self.navigationItem.title=@"问题详情";
    self.tableView.hidden=NO;
    [self initData];
    [self getData];
}
/**设置刷新*/
-(void) setRefresh{
    if(_isRefresh==YES) return;
    [self.tableView headerBeginRefreshing];
    _isRefresh=YES;
    [self.tableView addHeaderWithCallback:^{
        [self.questionList removeAllObjects];
        [self getData];
        _isRefresh=NO;
    }];
}
/**初始化数据*/
-(void)initData{
    _questionList=[NSMutableArray array];
}
/**提问*/
-(void) questionAddClick:(UIButton *)sender
{
    
    self.tableView.scrollEnabled=NO;
    self.navigationItem.title=@"添加咨询";
    if(_isShow==YES) return;
    QuestionSubmitViewController *questionSubmitVc=[[QuestionSubmitViewController alloc] init];
    questionSubmitVc.view.frame=CGRectMake(0, ScreenHeight,ScreenWidth, 400);
    UIButton *cover=[[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    cover.backgroundColor=[UIColor clearColor];
    cover.backgroundColor=HAColor(39, 39, 39);
    [cover addTarget:self action:@selector(dismissCover:) forControlEvents:UIControlEventTouchDown];
    [cover addSubview:questionSubmitVc.view];
    _cover =cover;
    _isShow=YES;
    CGFloat duration = 0.3; // 动画的时间
    [UIView animateWithDuration:duration animations:^{
        questionSubmitVc.view.transform = CGAffineTransformMakeTranslation(0, -400);
        _submitView=questionSubmitVc.view;
    }];
    [self.view addSubview:cover];
    
}
/**取消遮盖*/
-(void) dismissCover:(UIButton *)cover{
    self.navigationItem.title=@"咨询服务";
    CGFloat duration = 0.3; // 动画的时间
    [UIView animateWithDuration:duration animations:^{
        _submitView.transform = CGAffineTransformIdentity;
        cover.backgroundColor=[UIColor clearColor];
    } completion:^(BOOL finished) {
        [cover removeFromSuperview];
        self.tableView.scrollEnabled=YES;
        _isShow=NO;
    }];
    
}
//点击了提交按钮，移除遮盖
-(void) removeCover:(NSNotification *)noti{
    self.navigationItem.title=@"咨询服务";
    //移除遮盖，并刷新
    [self dismissCover:_cover];
    
    //刷新列表
    [self.tableView headerBeginRefreshing];
    
}
-(void) getData{
    [MBProgressHUD showMessage:@"正在加载咨询列表"];
    _mrg=[[AFHTTPRequestOperationManager alloc] init];
    [_mrg.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _mrg.requestSerializer.timeoutInterval = 10.f;
    [_mrg.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    _mrg.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userNo"]=[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo];
    NSString *url=[NSString stringWithFormat:@"%@consult/questions",MainURL];
    [_mrg GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUD];
        QuestionListModel *listModel=[QuestionListModel objectWithJSONData:responseObject];
        //QuestionModel的集合
        NSArray *questionLists=listModel.questionList;
        NSArray *newFrames= [self questionFramesWithQuestions:questionLists];
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [_questionFrames insertObjects:newFrames atIndexes:set];
        [_questionList addObjectsFromArray:listModel.questionList];
        if(_questionList.count==0){
            [MBProgressHUD showError:@"您还没添加任何咨询"];
        }
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showError:@"本机网络不稳定，请稍候再试"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self.navigationController popViewControllerAnimated:YES];
        });
        HALog(@"error");
    }];
}
/** 将QuestionModel模型转为QuestionModelFrame模型*/
- (NSArray *)questionFramesWithQuestions:(NSArray *)questions
{
    NSMutableArray *frames = [NSMutableArray array];
    for (QuestionModel *model in questions) {
        QuestionModelFrame *f = [[QuestionModelFrame alloc] init];
        f.questionModel=model;
        [frames addObject:f];
    }
    return frames;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _questionList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HAQuestionCell *cell=[HAQuestionCell cellWithTableView:tableView];
    cell.questionModelFrame=_questionFrames[indexPath.row];
    if(indexPath.row ==0){
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wz_list_01.jpg"]]];
    }else{
     //判断奇偶数
        if(indexPath.row % 2 == 1){
            [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wz_list_02.jpg"]]];
        }else{
            [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wz_list_03.jpg"]]];
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QuestionModel *result=[_questionList objectAtIndex:indexPath.row];
    QuestionDetailViewController *vc=[[QuestionDetailViewController alloc] init];
    vc.questionIdStr=result.questionId;
    QuestionModelFrame *f=[self.questionFrames objectAtIndex:indexPath.row];
    vc.questionModelFrame=f;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    QuestionModelFrame *modelFrame=self.questionFrames[indexPath.row];
    return 60;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
/**删除一个问题*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        QuestionModel *result=_questionList[indexPath.row];
        self.mrg=[[AFHTTPRequestOperationManager alloc] init];
        _mrg.responseSerializer=[AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        params[@"questionId"]=result.questionId;
        NSString *url=[NSString stringWithFormat:@"%@/consult/delete",MainURL];
        [_mrg GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [_questionList removeObjectAtIndex:indexPath.row];
            [tableView setEditing: NO animated: YES ];
            [tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}
@end
