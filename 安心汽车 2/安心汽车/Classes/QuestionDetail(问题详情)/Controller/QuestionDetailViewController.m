//
//  QuestionDetailViewController.m
//  提问列表demo1
//
//  Created by un2lock on 15/4/22.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "QuestionDetailViewController.h"
#import "KeyBordVIew.h"
#import "HAMessageModel.h"
#import "HAMessageCell.h"
#import "HAMessageFrameModel.h"
#import "QuestionDetailModel.h"
#import "QuestionDetailListModel.h"
#import "HAQuestionDetailTopView.h"
#import "HADetailPhotosView.h"
#import "HADetailVoicesView.h"
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface QuestionDetailViewController ()<UITableViewDataSource,UITableViewDelegate,KeyBordVIewDelegate,AVAudioPlayerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,HAMessageCellDelegate>
@property(nonatomic,strong) AFHTTPRequestOperationManager *mrg;
@property(nonatomic,strong) HAQuestionDetailTopView *topView;
/** 消息的字典*/
@property (nonatomic, strong)NSMutableArray *messages;
/** 显示消息的消息tableview*/
@property (strong, nonatomic) UITableView *tableView;
/** 是否正在录音*/
@property (nonatomic,assign) BOOL recording;
/** 录音器*/
@property (nonatomic,strong) AVAudioRecorder *recorder;
/** 音频播放器*/
@property (nonatomic,strong) AVAudioPlayer *player;
/*键盘界面*/
@property(nonatomic,strong) KeyBordVIew *keyBordView;
/*录音的文件路径*/
@property (nonatomic,strong) NSString *fileName;
/***/
@property(nonatomic,strong) NSURL *fileUrl;
/**文件的data数据*/
@property(nonatomic,strong) NSData *fileData;
/**
 *  图片集合
 */
@property(nonatomic,strong) HADetailPhotosView *detailPhotoView;
/**
 *  语音集合
 */
@property(nonatomic,strong) HADetailVoicesView *detailVoicesView;
@property(nonatomic,strong) NSMutableArray *imageFiles;
@property(nonatomic,strong) NSMutableArray *voiceFiles;
@property(nonatomic,strong) UIView *recoderbackView;
@end

@implementation QuestionDetailViewController
//questionIdStr
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //添加键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}
/**返回按钮*/
-(void) backClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    self.navigationItem.title=@"咨询详情";
    HAQuestionDetailTopView *topView=[[HAQuestionDetailTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
    topView.questionModelFrame=_questionModelFrame;
    topView.backgroundColor=[UIColor whiteColor];
    _topView=topView;
    [self.view addSubview:topView];
    
//    CGFloat iconLabelY=CGRectGetMaxY(topView.frame)-2;
//    UILabel *iconLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, iconLabelY, ScreenWidth, 15)];
//    iconLabel.text=@"图片区";
//    iconLabel.font=[UIFont systemFontOfSize:12.0];
//    iconLabel.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:iconLabel];
    
    CGFloat detailPhotoViewY=CGRectGetMaxY(topView.frame);
    HADetailPhotosView *detailPhotoView=[[HADetailPhotosView alloc] initWithFrame:CGRectMake(0, detailPhotoViewY, ScreenW, 60)];
    detailPhotoView.photos=nil;
    detailPhotoView.backgroundColor=[UIColor whiteColor];
    _detailPhotoView=detailPhotoView;
    _detailPhotoView.hidden=YES;
    [self.view addSubview:detailPhotoView];
    
    
//    CGFloat voiceLabelY=CGRectGetMaxY(detailPhotoView.frame)-2;
//    UILabel *voiceLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, voiceLabelY, ScreenWidth, 15)];
//    voiceLabel.text=@"语音区";
//    voiceLabel.font=[UIFont systemFontOfSize:12.0];
//    voiceLabel.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:voiceLabel];
    
    CGFloat detailVoiceViewY=CGRectGetMaxY(detailPhotoView.frame);
    HADetailVoicesView *detailVoicesView=[[HADetailVoicesView alloc] initWithFrame:CGRectMake(0, detailVoiceViewY, ScreenW, 60)];
    detailVoicesView.backgroundColor=[UIColor whiteColor];
    _detailVoicesView=detailVoicesView;
    _detailVoicesView.hidden=YES;
    [self.view addSubview:detailVoicesView];
    
    
    //网络获取聊天数据
    [self getContentData];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, ScreenW, ScreenHeight-44-topView.height-64)];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;

    [self.view addSubview:self.tableView];

    //添加键盘
    self.keyBordView=[[KeyBordVIew alloc]initWithFrame:CGRectMake(0, ScreenH-108, ScreenW, 44)];
    self.keyBordView.delegate=self;
    [self.view addSubview:self.keyBordView];
    
    [self getImageContent];
    [self tableViewScrollCurrentIndexPath];
}
-(void) initData{
    _imageFiles=[NSMutableArray array];
    _voiceFiles=[NSMutableArray array];
    
}
/**获取5张图片*/
-(void) getImageContent{
//    http://file.ywsoftware.com:9090/T100040/consult/showAsk
    [MBProgressHUD showMessage:@"正在加载图片与语音中"];
    _mrg=[[AFHTTPRequestOperationManager alloc] init];
    _mrg.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"questionId"]=_questionIdStr;
    NSString *urlStr=[NSString stringWithFormat:@"%@/consult/showAsk",MainURL];
    [_mrg GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray *datas=dict[@"fileList"];
        for (int i=0; i<datas.count; i++) {
            NSDictionary *dict=[datas objectAtIndex:i];
            NSNumber *fileFlag=dict[@"fileFlag"];
            if([@1 isEqualToNumber:fileFlag]){
                NSString *filePath=dict[@"filePath"];
                [_imageFiles addObject:filePath];
            }else{
                NSString *filePath=dict[@"filePath"];
                [_voiceFiles addObject:filePath];
            }
        }
        
        if(_imageFiles.count>0){//有图
            _detailPhotoView.hidden=NO;
            _detailPhotoView.y=60;
            self.tableView.y+=60;
            self.tableView.height-=60;
            [_detailPhotoView setPhotos:_imageFiles];
            if(_voiceFiles.count>0){
                _detailVoicesView.hidden=NO;
                _detailVoicesView.y=120;
                self.tableView.y+=60;
                self.tableView.height-=60;
                [_detailVoicesView setVoices:_voiceFiles];
            }else{
                _detailVoicesView.hidden=YES;
            }
        }else{//没有图
            _detailPhotoView.hidden=YES;
            if(_voiceFiles.count>0){
                _detailVoicesView.hidden=NO;
                _detailVoicesView.y=60;
                self.tableView.y+=60;
                self.tableView.height-=60;
                [_detailVoicesView setVoices:_voiceFiles];
            }else{
                _detailVoicesView.hidden=YES;
            }
        }
        //设置值
        [MBProgressHUD hideHUD];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showError:@"本机网络不稳定，请稍候再试."];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

/**网络获取聊天数据*/
-(void) getContentData{
    _mrg=[[AFHTTPRequestOperationManager alloc] init];
    _mrg.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"questionId"]=_questionIdStr;
    NSString *urlStr=[NSString stringWithFormat:@"%@/consult/detail",MainURL];
    [_mrg GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        QuestionDetailListModel *result=[QuestionDetailListModel objectWithJSONData:responseObject];
        NSMutableArray *messageArr = [NSMutableArray array];
        for (QuestionDetailModel *model in result.replyList) {
            HAMessageModel *messga = [[HAMessageModel alloc] init];
            messga.text=model.replyContent;
            if([model.replyFlag isEqualToNumber:@0]){
                //文字
                messga.contentType=HAMessageModelText;
            } else if([model.replyFlag isEqualToNumber:@1]){
                //图片
                messga.contentType=HAMessageModelImage;
                if([messga.text hasPrefix:@"http://"]){
                    messga.imageFromType=HAMessageImageNet;
                }else{
                    messga.imageFromType=HAMessageImageLocal;
                }
            }else if([model.replyFlag isEqualToNumber:@2]){
                //语音
                messga.contentType=HAMessageModelVoice;
                if([messga.text hasPrefix:@"http://"]){
                    messga.voiceFromType=HAMessageVoiceNet;
                }else{
                     messga.voiceFromType=HAMessageVoiceLocal;
                }
            }
            if([model.roleType isEqualToNumber:@1]){
                //客户
                messga.type=HAMessageModelMe;
            }else if([model.roleType isEqualToNumber:@0]){
                //服务
                messga.type=HAMessageModelServers;
            }
            messga.time=model.replyTime;
            //取出上一个模型
            HAMessageFrameModel *lastFm = [messageArr lastObject];
            //隐藏时间
            messga.hideTime = [messga.time isEqualToString:lastFm.message.time];
            HAMessageFrameModel *fm = [[HAMessageFrameModel alloc]init];
            fm.message = messga;
            [messageArr addObject:fm];
        }
        _messages = messageArr;
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/**键盘显示*/
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.view.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
/**
 *  键盘隐藏
 */
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        _topView.transform=CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformIdentity;
    }];
}
/**开始录音*/
-(void)beginRecord
{
    if(self.recording)return;
    
    self.recording=YES;
    
    //出现动画
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIImageView *recoderView=[[UIImageView alloc] init];
    UIView *recoderbackView=[[UIView alloc] init];
    recoderbackView.backgroundColor=[UIColor grayColor];
    recoderbackView.width=80;
    recoderbackView.height=80;
    recoderbackView.x=(ScreenWidth-100)/2;
    recoderbackView.y=(ScreenHeight-100)/2;
    
    recoderView.width=60;
    recoderView.height=60;
    recoderView.x=(recoderbackView.width-recoderView.width)/2;
    recoderView.y=(recoderbackView.height-recoderView.height)/2;;
    //添加动画
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 1; i < 15; i++) {
        NSString *imageName=[NSString stringWithFormat:@"record_animate_%d",i];
        [arrayM addObject:[UIImage imageNamed:imageName]];
    }
    
    recoderView.animationImages = arrayM;
    recoderView.animationRepeatCount = 1000;
    recoderView.animationDuration = arrayM.count * 0.075;
    [recoderView startAnimating];
    
    recoderView.backgroundColor=[UIColor redColor];
    [recoderbackView addSubview:recoderView];
    _recoderbackView=recoderbackView;
    [window addSubview:recoderbackView];
    
    
    
    
    NSDictionary *settings=[NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithFloat:8000],AVSampleRateKey,
                            [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,
                            [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                            [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                            nil];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    int randomNumber = (arc4random() % 20000) + 12000;
    NSString *fileName = [NSString stringWithFormat:@"rec_%d.wav",randomNumber];
    self.fileName=fileName;
    NSString *filePath=[NSString documentPathWith:fileName];
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    self.fileUrl=fileUrl;
    NSError *error;
    self.recorder=[[AVAudioRecorder alloc]initWithURL:fileUrl settings:settings error:&error];
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    [self.recorder peakPowerForChannel:0];
    [self.recorder record];
    
}
/**结束录音*/
-(void)finishRecord
{
    self.recording=NO;
    [self.recorder stop];
    [_recoderbackView removeFromSuperview];
    self.recorder=nil;
    
    
    HAMessageModel *msg=[[HAMessageModel alloc] init];
    //当前时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    msg.time=locationString;

    NSString *filePath=[NSString documentPathWith:_fileName];
    //上传录音
   
    
    [self uploadVoice:filePath];
    msg.text=filePath;  //传递录音的地址
    msg.contentType=HAMessageModelVoice;
    msg.type=HAMessageModelMe;
    [self addmessage:msg];
    
    [self.tableView reloadData];
    
    [self tableViewScrollCurrentIndexPath];
    
}
/**上传语音*/
- (void)uploadVoice:(NSString *)filePath
{
    // 1.创建一个管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    [mgr.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-type"];
    // 2.封装参数(这个字典只能放非文件参数)
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"questionId"] = _questionIdStr;
    params[@"userNo"] = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo];
    params[@"replyFlag"]=@2;
    
    // 2.发送一个请求
    NSString *url = [NSString stringWithFormat:@"%@upload.s",MainURL];
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data=[NSData dataWithContentsOfFile:filePath];
        [formData appendPartWithFileData:data name:@"upload" fileName:_fileName mimeType:@"audio/x-wav"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HALog(@"上传成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HALog(@"上传失败的原因 %@",error);
    }];
}
//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
/**滚动时隐藏键盘*/
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)addmessage:(HAMessageModel *)msg{
    //设置内容的frame
    HAMessageFrameModel *fm = [[HAMessageFrameModel alloc]init];
    //将msg 赋值给 fm 中的message
    fm.message = msg;
    [self.messages addObject:fm];
    
    //2.刷新表格
    [self.tableView reloadData];
}

/**点击返回键时的操作*/
-(void)KeyBordView:(KeyBordVIew *)keyBoardView textFiledReturn:(UITextField *)textFiled
{
    if(textFiled.text.length<0 || [textFiled.text isEqualToString:@""]) return;
    //上传到服务器
    [self uploadText:textFiled.text];
    //给tableview发送文字并刷新表格
    HAMessageModel *msg=[[HAMessageModel alloc] init];
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    
    msg.time=locationString;
    msg.text=textFiled.text;
    msg.contentType=HAMessageModelText;
    msg.type=HAMessageModelMe;
    [self addmessage:msg];
    
    [self.tableView reloadData];
    
    //滚动到当前行
    [self tableViewScrollCurrentIndexPath];
    textFiled.text=@"";
}
/**上传文字*/
-(void) uploadText:(NSString *)text{
    // 1.创建一个管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    // 2.封装参数(这个字典只能放非文件参数)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"questionId"] = _questionIdStr;
    params[@"userNo"] = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo];
    params[@"replyFlag"]=@"0";
    params[@"replyContent"]=text;
    // 2.发送一个请求
    NSString *url = [NSString stringWithFormat:@"%@consult/sendReplyContent",MainURL];
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}
-(void)KeyBordView:(KeyBordVIew *)keyBoardView textFiledBegin:(UITextField *)textFiled
{
    [self tableViewScrollCurrentIndexPath];
}
/**点击了选择图片的按钮*/
-(void)clickChoosePicture:(UIButton *)image{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [sheet showInView:self.view.window];
}
#pragma mark - UIActionSheet 代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    // 设置代理
    ipc.delegate = self;
    
    switch (buttonIndex) {
        case 0: { // 拍照
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        }
        case 1: { // 相册
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
        case 2: { // 取消
            return ;
            break;
        }
        default:
            break;
    }
    // 显示控制器
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
/**在选择完图片后调用 里面包含了图片信息*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 获得图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self uploadImage:image];  //上传图片
    
    HAMessageModel *msg=[[HAMessageModel alloc] init];
    
    NSDate * senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    
    msg.time=locationString;
    msg.image=image;
    msg.contentType=HAMessageModelImage;
    msg.type=HAMessageModelMe;
    msg.imageFromType=HAMessageImageLocal;
    [self addmessage:msg];
    
    [self tableViewScrollCurrentIndexPath];  //滚动到当前行
    [self.tableView reloadData];
}
/**上传图片*/
- (void)uploadImage:(UIImage *)image
{
    // 1.创建一个管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    [mgr.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-type"];
    // 2.封装参数(这个字典只能放非文件参数)
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"questionId"] = _questionIdStr;
    params[@"userNo"] = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo];
    params[@"replyFlag"]=@1;
    int randomNumber = (arc4random() % 20000) + 12000;
    // 2.发送一个请求
    NSString *url = @"http://file.ywsoftware.com:9090/T100040/upload.s";
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imagedata=UIImageJPEGRepresentation(image,0.75);
        [formData appendPartWithFileData:imagedata name:@"upload" fileName:[NSString stringWithFormat:@"%d.png",randomNumber] mimeType:@"image/png"];

    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HALog(@"上传成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HALog(@"上传失败的原因 %@",error);
    }];
}
/** 滚动到最下面一行*/
-(void)tableViewScrollCurrentIndexPath
{
    if(self.messages.count>0){
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.messages.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
-(void)initPlayer{
    //初始化播放器的时候如下设置
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    audioSession = nil;
}

#pragma mark tableview数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HAMessageFrameModel *model = self.messages[indexPath.row];
    return model.cellH;//cell 的高度
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"TimeLineCell%d%d",indexPath.section,indexPath.row];
    HAMessageCell *cell=[[HAMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    //初始化cell
    //    HAMessageCell *cell = [HAMessageCell messageCellWithTableView:tableView];
    //取出model
    HAMessageFrameModel *model = self.messages[indexPath.row];
    //设置model
    cell.frameMessage = model;
    return cell;
}
@end
