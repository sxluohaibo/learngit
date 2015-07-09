//
//  HAFeedBackTextView.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/22.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  自定义TEXTVIEW

#import <UIKit/UIKit.h>

@interface HAFeedBackTextView : UITextView


/**textView的占位符文子*/
@property(nonatomic,copy) NSString* placehold;

/**textView的占位符文字的文子*/
@property(nonatomic,strong) UIColor * placeholdColor;


@end
