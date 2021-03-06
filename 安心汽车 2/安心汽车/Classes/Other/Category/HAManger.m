//
//  HAManger.m
//  安心汽车
//
//  Created by 孔伟 on 15/3/4.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAManger.h"
#import "GTMBase64.h"
#include <CommonCrypto/CommonCryptor.h>

@implementation HAManger

//解码
+ (NSString*)decryptUseDES:(NSString*)cipherText key:(NSString*)key {
    // 利用 GTMBase64 解碼 Base64 字串
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[2048];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          2048,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}


//编码
+ (NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    NSData *data = [clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    unsigned char buffer[2048];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          2048,
                                          &numBytesEncrypted);
    
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText = [GTMBase64 stringByEncodingData:dataTemp];
    }else{
        NSLog(@"DES加密失败");
    }
    return plainText;
}

+(NSInteger)checkVersion:(NSString *)url{
    //http://www.che-henry.net/huaaomobileservice/update/update_ios_version_huaaomobile.txt
    //1.获取网络更新版本文件
    //2.获取数据信息的字典
    NSDictionary *dict = [[NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil]  objectFromJSONString];
    HAVersionModel *model=[HAVersionModel versionWithDict:dict];
    //3.获取应用版本号
    float localVersion=[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue];
    NSLog(@"localVersion:%f",localVersion);
    if(localVersion < [[model vercode] intValue]){
        return 1;
    }else{
        return 0;
    }
}

//字符串的包涵
+(NSString *)HAReplaceString:(NSString *)replaceString excuseString:(NSString *)excuse replaceSting:(NSString *)replace{
    NSString *tempString = nil;
    if([replaceString rangeOfString:excuse].location != NSNotFound){
        NSLog(@"字符串存在＋");
        tempString = [replaceString stringByReplacingOccurrencesOfString:excuse withString:replace];
        return tempString;
    }
    return replaceString;
}

//取代
+(BOOL)HAReplaceString:(NSString *)replaceString excuseString:(NSString *)excuse{
    if([replaceString rangeOfString:excuse].location != NSNotFound){
        return YES;
    }
    return NO;
}

//添加信息到UserInfoIOS接口
+(void)AddUserMobileUseInfoIOS:(NSString *)username userID:(NSString *)userID{
    float localVersion=[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue];
    NSString *downName = [NSString stringWithFormat:@"v3/MobileService.asmx/AddUserMobileUseInfoIOS?userName=%@&userID=%@&version=%f&key=%@",username,userID,localVersion,@"ywkj2014@huaao2008!"];
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:nil httpMethod:@"GET" ssl:NO];
    NSLog(@"op.url == %@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"下载完成 == %@",completedOperation.responseString);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error ＝＝  %@",error);
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
}

//字符串转换成NSDate
+ (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

//NSDate转换成字符串
+ (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

#define OneDay 86400
//获取保养的时间
+(NSString *)getBaoYangTime:(NSString *)time{
    
    //NSArray *tempArr = [time componentsSeparatedByString:@"-"];
    
    NSLog(@"time %@",time);
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"YYYY-MM-dd"];
    NSDate *oldDate= [dateFormatter dateFromString:time];
    
    NSTimeInterval oldTime = [oldDate timeIntervalSince1970];
    
    int xx = nowTime-oldTime;
    NSLog(@"xx == %d",xx);
    
    int yy = xx%(OneDay*120);
    NSLog(@"yy == %d",yy);
    
    int zz = OneDay*120-yy;
    NSLog(@"zz == %d",zz);
    
    int mm = zz+nowTime;
    
    NSLog(@"mm == %d",mm);

    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:mm];
    NSString *confromTimespStr = [dateFormatter stringFromDate:confromTimesp];
    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    //NSLog(@"yy == %d",yy);
    //int zz = yy/OneDay;
    //NSLog(@"zz %d",zz);
    NSLog(@"nowTime == %f",nowTime);
    NSLog(@"oldTime == %f",oldTime);
    return confromTimespStr;
    return nil;
}


//时间的比较
+(BOOL)HAbackTime:(NSString *)changeDate{
    //现在的时间戳
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"当前时间的时间戳 %f",nowTime);
    NSString *nowDate = [NSString stringWithFormat:@"%f",nowTime];
    
    NSInteger result = (long)[changeDate integerValue] - (long)[nowDate integerValue];
    NSLog(@"结果 ＝＝ %ld",((long)[changeDate integerValue])-(long)[nowDate integerValue]);
    if (result >= [TEN_DAYS integerValue]) {
        NSLog(@"要登陆");
        return YES;
    }else{
        NSLog(@"不要登陆");
        return NO;//不用重新登录
    }
}

+(NSString *)HAUTF8Change:(NSString *)tempString{
    if ([tempString isEqualToString:@""]) {
        return @"";
    }
    NSString *urlString = tempString;
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlString, NULL, NULL,  kCFStringEncodingUTF8));
    return encodedString;
}

//城市的解析
+(NSArray *)ParseProviceResultData:(NSDictionary *)resultData{
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    NSArray *tempArr = [resultData objectForKey:@"result"];
    
    for (int i = 0; i < tempArr.count; i++) {
        NSDictionary *dic = [tempArr objectAtIndex:i];
        HAViolationProvicePrameResult *provioceprameResult = [[HAViolationProvicePrameResult alloc] init];
        provioceprameResult.province = [dic objectForKey:@"province"];
        provioceprameResult.province_code = [dic objectForKey:@"province_code"];
        
        //city模型
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        NSArray *array = [dic objectForKey:@"citys"];
        for (int j = 0; j < array.count; j++) {
            NSDictionary *tempDic = [array objectAtIndex:j];
            HAViolationCitysParameResult *cityResult = [[HAViolationCitysParameResult alloc] init];
            cityResult.city_name = [tempDic objectForKey:@"city_name"];
            cityResult.city_code = [tempDic objectForKey:@"city_code"];
            NSString *code = [tempDic objectForKey:@"city_code"];
            NSString *provice_code = nil;
            if ([HAManger HAReplaceString:code excuseString:@"_"]) {
                NSArray *codeArr = [code componentsSeparatedByString:@"_"];
                provice_code = [codeArr objectAtIndex:0];
            }else{
                provice_code = code;
            }
            cityResult.province_code = provice_code;
            cityResult.abbr = [tempDic objectForKey:@"abbr"];
            cityResult.engine = [[tempDic objectForKey:@"engine"] boolValue];
            cityResult.engineno = [[tempDic objectForKey:@"engineno"] integerValue];
            cityResult.classa = [[tempDic objectForKey:@"classa"] boolValue];
            cityResult.classno = [[tempDic objectForKey:@"classno"] integerValue];
            cityResult.regist = [[tempDic objectForKey:@"regist"] boolValue];
            cityResult.registno = [[tempDic objectForKey:@"registno"] integerValue];
            [arr addObject:cityResult];
            provioceprameResult.citys = arr;
        }
        [resultArr addObject:provioceprameResult];
    }
    return resultArr;
}

//得到用户车辆的信息
+ (HACarInfoResult *)parseCarResult:(NSDictionary *)data{
    HACarInfoResult *info = [[HACarInfoResult alloc] init];
    info.result = [data objectForKey:@"result"];
    info.resultCode = [data objectForKey:@"resultCode"];
    HACarResult *result = [[HACarResult alloc] init];
    result.address = [[data objectForKey:@"carInfo"] objectForKey:@"address"];
    result.carBand = [[data objectForKey:@"carInfo"] objectForKey:@"carBand"];
    result.carNo = [[data objectForKey:@"carInfo"] objectForKey:@"carNo"];
    result.carbuyDate = [[data objectForKey:@"carInfo"] objectForKey:@"carbuyDate"];
    result.partnerID = [[data objectForKey:@"carInfo"] objectForKey:@"partnerID"];
    result.partnerLocation = [[data objectForKey:@"carInfo"] objectForKey:@"partnerLocation"];
    result.partnerName = [[data objectForKey:@"carInfo"] objectForKey:@"partnerName"];
    info.carResult = result;
    return info;
}


//得到用户输入的模型
+ (HAUserInputModel *)parseUserInput:(NSDictionary *)data{
    HAUserInputModel *input = [[HAUserInputModel alloc] init];
    input.vioArea = [data objectForKey:violationArea];
    input.carTypeNumber = [data objectForKey:carTypeNO];
    input.classNumber = [data objectForKey:classNO];
    input.engineNumber = [data objectForKey:engineNo];
    input.registNumber = [data objectForKey:registerNO];
    input.remarkNumber = [data objectForKey:remarkNO];
    input.carTypeShort = [data objectForKey:carTYShort];
    input.userNO = [data objectForKey:LoginUserNo];
    return input;
}

@end
