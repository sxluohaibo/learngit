//
//  QuestionSubmitViewController.m
//  提问列表demo1
//
//  Created by un2lock on 15/4/27.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "QuestionSubmitViewController.h"
#import "HAPhotosView.h"
#import "HAVoicesView.h"
#import "HAMineLoveCarDBOperator.h"
#import "HACarBrandChoiceView.h"
#import "HALoveCarModel.h"
#import "HACarNumberBtn.h"

#define  NormalPadding 7
#define ButtonPadding 16
#define ButtonW 90
#define carRankBtnW 120
@interface QuestionSubmitViewController () <UITextFieldDelegate,UIImagePickerControllerDelegate,HAPhotosViewDelegate,HAVoicesViewDelegate,carBrandChoiceDelegate>
@property(nonatomic,weak) HAPhotosView *photoView;
@property(nonatomic,weak) HAVoicesView *voiceView;
@property(nonatomic,strong) NSMutableArray *photosArray;
@property(nonatomic,strong) NSMutableArray *voicesArray;
@property(nonatomic,strong) UIScrollView *scrollView;
/*提交的问题内容*/
@property(nonatomic,weak) UITextField *questionFiled;
/*网络返回的图片字段信息*/
@property(nonatomic,strong) NSMutableArray *resultImageArray;
/*网络返回的语音字段信息*/
@property(nonatomic,strong) NSMutableArray *resultVoiceArray;
/** 录音器*/
@property (nonatomic,strong) AVAudioRecorder *recorder;
/** 是否正在录音*/
@property (nonatomic,assign) BOOL recording;
@property(nonatomic,weak) UIButton *selectedBtn;
/*录音文件的voice地址*/
@property(nonatomic,copy) NSString *voicePath;
@property(nonatomic,copy) NSString *VoicefileName;
/**最后点击的按钮*/
@property(nonatomic,weak) UIButton *lastBtn;
/**车型显示的按钮*/
@property(nonatomic,weak) UIButton *carRankBtn;
@property(nonatomic,weak) HACarBrandChoiceView *choiceView;
@property(nonatomic,weak) UIView *recoderbackView;
@end

@implementation QuestionSubmitViewController
-(void) initArray{
    _photosArray=[NSMutableArray array];  //本地拍好照片的集合
    _voicesArray=[NSMutableArray array];
    
    _resultImageArray=[NSMutableArray array];  //网络返回的图片集合初始化
    _resultVoiceArray=[NSMutableArray array];  //网络返回的语音集合初始化
    
    
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
- (void)viewDidLoad {
    [self initPlayer];
    [super viewDidLoad];
    self.view.backgroundColor=HAColor(229, 229,229);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changCarbrand:) name:CarClassPickNotification object:nil];

    [self initArray];
    
    //输入您想咨询的问题
    
    //问题咨询区
    UIImageView *textIcon=[[UIImageView alloc] initWithFrame:CGRectMake(14, 9, 39, 27)];
    [textIcon setImage:[UIImage imageNamed:@"text_icon"]];
    [self.view addSubview:textIcon];
    CGFloat questionFiledX=textIcon.x+textIcon.width + 4;
    CGFloat questionFiledY=textIcon.y;
    CGFloat questionFiledW=ScreenWidth - questionFiledX - 15;
    CGFloat questionFiledH=textIcon.height;
    UITextField *questionFiled=[[UITextField alloc] initWithFrame:CGRectMake(questionFiledX, questionFiledY, questionFiledW, questionFiledH)];
    questionFiled.placeholder=@"输入您想咨询的问题";
    questionFiled.font=[UIFont systemFontOfSize:13.0f];
    [questionFiled setBackground:[UIImage imageNamed:@"text_box_bg"]];
    questionFiled.delegate=self;
    _questionFiled=questionFiled;
    [self.view addSubview:questionFiled];
    
    
    CGFloat line1W=textIcon.width + questionFiled.width + NormalPadding;
    CGFloat line1Y=textIcon.y + 7 +textIcon.height;
    UILabel *line1=[[UILabel alloc] initWithFrame:CGRectMake(textIcon.x,line1Y, line1W, 1)];
    [line1 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dots_divider"]]];
    [self.view addSubview:line1];
    
    //选择图片区
    
    HAPhotosView *photoView=[[HAPhotosView alloc] init];
    photoView.delegate=self;
    photoView.x=0;
    photoView.y=line1.y+line1.height;
    photoView.width=ScreenWidth;
    photoView.height=48;
    _photoView=photoView;
    [self.view addSubview:photoView];
    
    //选择语音
    HAVoicesView *voiceView=[[HAVoicesView alloc] init];
    voiceView.delegate=self;
    voiceView.x=0;
    voiceView.y= photoView.y + photoView.height;
    voiceView.width=ScreenWidth;
    voiceView.height=48;
    _voiceView=voiceView;
    
    [self.view addSubview:voiceView];
    
    //第二分隔线
    CGFloat line2Y=voiceView.y +voiceView.height;
    UILabel *line2=[[UILabel alloc] initWithFrame:CGRectMake(line1.x, line2Y,line1W, 1)];
    [line2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dots_divider"]]];
    [self.view addSubview:line2];

    //选择车型
    UILabel *carChooseLabel=[[UILabel alloc] initWithFrame:CGRectMake(textIcon.x, line2.y+line2.height +10 , 150, 11)];
    carChooseLabel.text=@"选择您的车型(必选):";
    carChooseLabel.backgroundColor = [UIColor clearColor];
    carChooseLabel.textAlignment = NSTextAlignmentLeft;
    carChooseLabel.font=[UIFont systemFontOfSize:12.0f];
    carChooseLabel.textColor=HAColor(90, 90, 90);
    [self.view addSubview:carChooseLabel];
    
    CGFloat carRankH=carChooseLabel.y + carChooseLabel.height+ 6;
    HACarNumberBtn *carRankBtn=[[HACarNumberBtn alloc] init];
    carRankBtn.titleLabel.text=@"点击选择车型";
    carRankBtn.x=textIcon.x;
    carRankBtn.y=carRankH;
    carRankBtn.width=carRankBtnW;
    carRankBtn.height=20;
    _carRankBtn=carRankBtn;
    [carRankBtn addTarget:self action:@selector(chooseCarClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:carRankBtn];

    CGFloat caraddBtnX=carRankBtn.x + carRankBtn.width + ButtonPadding;
    CGFloat caraddBtnY=carRankBtn.y;
    UIButton *caraddBtn=[self buttonCreate:CGRectMake(caraddBtnX,  caraddBtnY, carRankBtnW, 22) normalImageName:@"gray_bar" seletedImageName:@"" title:@"添加车型" titleColor:HAColor(90, 90, 90)];
    [caraddBtn addTarget:self action:@selector(addCar:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:caraddBtn];
    
    CGFloat line3Y=CGRectGetMaxY(caraddBtn.frame) + 8 ;
    UILabel *line3=[[UILabel alloc] initWithFrame:CGRectMake(line1.x, line3Y,line1W, 1)];
    [line3 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"line_divider"]]];
    [self.view addSubview:line3];

    //选择问题区
    CGFloat questionChooseLabelY=CGRectGetMaxY(line3.frame) + 8;
    UILabel *questionChooseLabel=[[UILabel alloc] initWithFrame:CGRectMake(textIcon.x, questionChooseLabelY, 150, 20)];
    questionChooseLabel.text=@"选择您问题的类型(必选):";
    questionChooseLabel.font=[UIFont systemFontOfSize:12.0f];
    questionChooseLabel.textColor=HAColor(90, 90, 90);
    [self.view addSubview:questionChooseLabel];
    //维修保养
    CGFloat wxbyBtnY=CGRectGetMaxY(questionChooseLabel.frame)+ 8;
    UIButton *wxybBtn=[self buttonTypeCreate:CGRectMake(textIcon.x, wxbyBtnY,ButtonW, 22) title:@"维修保养"];
    wxybBtn.selected=YES;
    [wxybBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    _lastBtn=wxybBtn;
    [self.view addSubview:wxybBtn];
    
    //系统客服
    CGFloat xtkfBtnX=wxybBtn.x + wxybBtn.width + ButtonPadding;
    UIButton *xtkfBtn=[self buttonTypeCreate:CGRectMake(xtkfBtnX,wxbyBtnY, ButtonW, 22) title:@"系统客服"];
    [xtkfBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xtkfBtn];
    
    CGFloat ycbxBtnX=xtkfBtn.x + xtkfBtn.width + ButtonPadding;
    UIButton *ycbxBtn=[self buttonTypeCreate:CGRectMake(ycbxBtnX,wxbyBtnY, ButtonW, 22) title:@"延长保修"];
    [ycbxBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ycbxBtn];
    
    //立即提交
    CGFloat submitBtnX=13;
    CGFloat submitBtnY=CGRectGetMaxY(wxybBtn.frame) + 44;
    CGFloat submitBtnW=ScreenWidth - 2 * submitBtnX;
    UIButton *submitBtn=[[UIButton alloc] initWithFrame:CGRectMake(submitBtnX,submitBtnY, submitBtnW, 29)];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"enter_bar"] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"enter_bar"] forState:UIControlStateHighlighted];
    submitBtn.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    [submitBtn setTitle:@"确认发布" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitToNet:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}
-(void) chooseCarClick:(UIButton *)sender{
    if(_choiceView.isShow){
        _choiceView.isShow=NO;
        [_choiceView removeFromSuperview];
    }else{
        NSArray *tempArr = [HAMineLoveCarDBOperator exqueryFMDBWithSql:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]];
        if(tempArr.count==0){
            [MBProgressHUD showError:@"您还没有添加过任何车信息"];
            return;
        }
//        HACarBrandChoiceView *choiceView = [[HACarBrandChoiceView alloc] initWithFrame:CGRectMake(sender.x, sender.y+20, sender.width, (tempArr.count-1)*44) andCarArr:tempArr];
        CGFloat tableH=0;
        if(tempArr.count==1){
            tableH=44;
        }else{
           tableH=3*44;
        }
        HACarBrandChoiceView *choiceView = [[HACarBrandChoiceView alloc] initWithFrame:CGRectMake(sender.x, sender.y+20, sender.width, tableH) andCarArr:tempArr];
        choiceView.delegate=self;
        choiceView.backgroundColor=[UIColor whiteColor];
        _choiceView=choiceView;
        _choiceView.isShow=YES;
        choiceView.userInteractionEnabled = YES;
        choiceView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:choiceView];
    }
    
}
-(void)clickCarBrand:(HACarBrandChoiceView *)view currentCarBrandText:(NSString *)currentCarBrandText{
    [_choiceView removeFromSuperview];
    [_carRankBtn setTitle:currentCarBrandText forState:UIControlStateNormal];
    [_carRankBtn setTitle:currentCarBrandText forState:UIControlStateHighlighted];
}
/**修改车型数据*/
-(void) changCarbrand:(NSNotification *)center{
    [_carRankBtn setTitle:@"请选择车型" forState:UIControlStateNormal];
}

-(void) addCar:(UIButton *)sender{
    ApplicationDelegate.loginType = 5;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addCarBrand" object:nil];
}

-(void)chooseBtn :(UIButton *)sender{
    _lastBtn.selected=NO;
    sender.selected=YES;
    _lastBtn=sender;
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
    
    //录音地址
    _voicePath=@"";
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
    int randomNumber = (arc4random() % 20000) + 12000;
    NSString *fileName = [NSString stringWithFormat:@"rec_%d.wav",randomNumber];
    NSString *filePath=[NSString documentPathWith:fileName];
    _voicePath=filePath;
    _VoicefileName=fileName;
    NSError *error;
    self.recorder=[[AVAudioRecorder alloc]initWithURL:[NSURL URLWithString:filePath] settings:settings error:&error];
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
    
    //上传语音
    [self uploadVoice:_voicePath];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)voiceView:(HAVoicesView *)voiceView recognizer:(UILongPressGestureRecognizer *)recognizer{
    if(_voicesArray.count==5){
        [MBProgressHUD showError:@"最多只能录五条语音"];
        return;
    }
    if(recognizer.state==UIGestureRecognizerStateBegan){
        [self beginRecord];
    }else if(recognizer.state==UIGestureRecognizerStateEnded){
        [self finishRecord];
        [_voiceView addVoice:_voicePath];
        [_voicesArray addObject:_voicePath];
    }
}
-(void)photoView:(HAPhotosView *)photoView{
    if(_photosArray.count==5){
        [MBProgressHUD showError:@"最多只能拍五张照片"];
        return;
    }
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [sheet showInView:self.view.window];
}
/**上传图片*/
-(void) uploadImage:(UIImage *)image{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    [mgr.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-type"];
    // 2.封装参数(这个字典只能放非文件参数)
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fileFlag"] = @1;  //type:1是图片
    int randomNumber = (arc4random() % 20000) + 12000;
    // 2.发送一个请求
    NSString *url = [NSString stringWithFormat:@"%@/questionUpload.s",MainURL];
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imagedata=UIImageJPEGRepresentation(image,0.75);
        [formData appendPartWithFileData:imagedata name:@"imageUpload" fileName:[NSString stringWithFormat:@"%d.png",randomNumber] mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HALog(@"提问－－图片：上传成功");
        NSNumber *fileFlag=responseObject[@"fileFlag"];
        if([fileFlag isEqualToNumber:@1]){
            //添加到图片返回的集合中
            NSString *fileName=responseObject[@"fileName"];
            [_resultImageArray addObject:fileName];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HALog(@"上传失败的原因 %@",error);
    }];
}
/**上传语音*/
-(void) uploadVoice:(NSString *)filePath{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    [mgr.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-type"];
    // 2.封装参数(这个字典只能放非文件参数)
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fileFlag"] = @2;  //type:2是语音
    int randomNumber = (arc4random() % 20000) + 12000;
    // 2.发送一个请求
    NSString *url = [NSString stringWithFormat:@"%@/questionUpload.s",MainURL];
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data=[NSData dataWithContentsOfFile:filePath];
        [formData appendPartWithFileData:data name:@"upload" fileName:_VoicefileName mimeType:@"audio/x-wav"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HALog(@"提问－－语音：上传成功");
        NSNumber *fileFlag=responseObject[@"fileFlag"];
        if([fileFlag isEqualToNumber:@2]){
            //添加到图片返回的集合中
            NSString *fileName=responseObject[@"fileName"];
            [_resultVoiceArray addObject:fileName];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HALog(@"上传失败的原因 %@",error);
    }];
}
-(void) submitToNet:(UIButton *) sender{
    NSString *questionText=_questionFiled.text;
    if(questionText.length <= 0 || [@"" isEqualToString:_questionFiled.text]){
        [MBProgressHUD showError:@"内容不能为空"];
        return ;
    }
    //点击选择车型
    NSString *carRankText=_carRankBtn.titleLabel.text;
    if([@"请选择车型" isEqualToString:carRankText]){
        [MBProgressHUD showError:@"请选择车型"];
        return;
    }
    sender.enabled=NO;
    // 1.创建一个管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    // 2.封装参数(这个字典只能放非文件参数)
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    // 2.封装参数(这个字典只能放非文件参数)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"question"] = _questionFiled.text;
    params[@"userNo"] = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo];
    NSString *imageFiles=@"";
    for (int i=0; i<_resultImageArray.count; i++) {
        if(i == (_resultImageArray.count -1)){
            imageFiles=[imageFiles stringByAppendingString:[NSString stringWithFormat:@"%@",[_resultImageArray objectAtIndex:i]]];
        }else{
            imageFiles=[imageFiles stringByAppendingString:[NSString stringWithFormat:@"%@|",[_resultImageArray objectAtIndex:i]]];
        }
    }
    NSString *voiceFiles=@"";
    for (int i=0; i<_resultVoiceArray.count; i++) {
        if(i == (_resultVoiceArray.count -1)){
            voiceFiles=[voiceFiles stringByAppendingString:[NSString stringWithFormat:@"%@",[_resultVoiceArray objectAtIndex:i]]];
        }else{
            voiceFiles=[voiceFiles stringByAppendingString:[NSString stringWithFormat:@"%@|",[_resultVoiceArray objectAtIndex:i]]];
        }
    }
    params[@"imageFiles"]=imageFiles;
    params[@"voiceFiles"]=voiceFiles;
    NSString *btnText=_lastBtn.titleLabel.text;  //按钮的选择
    NSString *btnType=nil;
    //1：维修保养，2：系统客服，3：延长保修
    if([@"维修保养" isEqualToString:btnText]){
        btnType=@"1";
    }else if([@"系统客服" isEqualToString:btnText]){
         btnType=@"2";
    }else if([@"延长保修" isEqualToString:btnText]){
         btnType=@"3";
    }
    params[@"questionType"]=btnType;
    NSString *carRanktext=_carRankBtn.titleLabel.text;
    if(carRanktext.length==0 || [@"" isEqualToString:carRanktext]){
        params[@"carBrand"]=@"";
    }else{
        params[@"carBrand"]=carRanktext;
    }
    
    // 2.发送一个请求
    NSString *url = [NSString stringWithFormat:@"%@consult/ask",MainURL];
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([@"success" isEqualToString:responseObject[@"result"]]){
            [MBProgressHUD showSuccess:@"添加成功"];
        }else{
            [MBProgressHUD showSuccess:@"服务器忙,请稍候再试"];
        }
        [[NSNotificationCenter  defaultCenter] postNotificationName:ClickSubmitBtnToNet object:nil];
        sender.enabled=YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HALog(@"error %@",error);
        [MBProgressHUD showSuccess:@"服务器忙,请稍候再试"];
        [[NSNotificationCenter  defaultCenter] postNotificationName:ClickSubmitBtnToNet object:nil];
        sender.enabled=YES;
    }];

}
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
//    UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
    UIWindow *window=[[UIApplication sharedApplication] keyWindow];
    [window.rootViewController presentViewController:ipc animated:YES completion:nil];
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
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
//    UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
    UIWindow *window=[[UIApplication sharedApplication] keyWindow];
    [window.rootViewController presentViewController:ipc animated:YES completion:nil];
}
/**在选择完图片后调用 里面包含了图片信息*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 获得图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //上传图片
    [self uploadImage:image];
    [_photoView addPhoto:image];  //添加到photoview里面显示
    [_photosArray addObject:image];  //添加到本地集合中
    
}
/** 创建类型按钮*/
-(UIButton *) buttonTypeCreate:(CGRect )frame title:(NSString *)title{
    UIButton *button=[[UIButton alloc] initWithFrame:frame];
    [button setBackgroundImage:[UIImage imageNamed:@"gray_bar"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"blue_bar"] forState:UIControlStateSelected];
    button.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitleColor:HAColor(90, 90, 90) forState:UIControlStateNormal];
    return button;
}
/** 创建按钮*/
-(UIButton *) buttonCreate:(CGRect )frame normalImageName:(NSString *) normalImageName seletedImageName:(NSString *)seletedImageName title:(NSString *)title titleColor:(UIColor *) titleColor{
    UIButton *button=[[UIButton alloc] initWithFrame:frame];
    [button setBackgroundImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    return button;
}
/**------------------------------------------------*/
@end
