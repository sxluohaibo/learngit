//
//  HAFeedBackTextView.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/22.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  自定义TEXTVIEW

#import "HAFeedBackTextView.h"


@interface HAFeedBackTextView ()

@property(nonatomic,weak) UILabel * placeHoldLable;
@end


@implementation HAFeedBackTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *placeHoldLable = [[UILabel alloc] init];
//        placeHoldLable.backgroundColor = [UIColor redColor];
        //设置占为符文字颜色
        placeHoldLable.textColor = [UIColor lightGrayColor];
        //默认为隐藏
        placeHoldLable.hidden = YES;
        placeHoldLable.numberOfLines = 0;
        self.placeHoldLable = placeHoldLable;
        placeHoldLable.font = [UIFont systemFontOfSize:13];
        [self insertSubview:self.placeHoldLable atIndex:0];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
    }
    
    return  self;
}


- (void)textDidChange
{
    self.placeHoldLable.hidden = (self.text.length!=0);
}



-(void)setPlaceholdColor:(UIColor *)placeholdColor
{
    self.placeHoldLable.textColor = placeholdColor;
}




- (void)setPlacehold:(NSString *)placehold
{
    _placehold = placehold;
    if (placehold.length) {
        
        self.placeHoldLable.hidden = NO;
        CGFloat placeholdLableX = 5;
        CGFloat placeholdLableY =8;
        
        CGFloat maxH = self.frame.size.height - 2 *   placeholdLableY;
        CGFloat maxW = self.frame.size.width - 2 *   placeholdLableX;
        
        CGSize placeholdsize = [placehold sizeWithFont:self.placeHoldLable.font constrainedToSize:CGSizeMake(maxW, maxH)];
        
        self.placeHoldLable.frame = (CGRect){{placeholdLableX,placeholdLableY},placeholdsize};
        self.placeHoldLable.text = placehold;
    }else{
        
        self.placeHoldLable.hidden = YES;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
