//
//  InputView.m
//  bling
//
//  Created by 楼 彬 on 17/6/7.
//  Copyright (c) 2017年 lb1006. All rights reserved.
//

#import "InputView.h"
#import "CustomLine.h"

@implementation InputView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initViews:frame];

    }
    
    return self;
}


#pragma mark PRIVATE METHOD

- (void)initViews:(CGRect)frame
{
    CGFloat textFieldHeight = 20.0f;
    
    //基本属性
    self.backgroundColor = [UIColor whiteColor];
    
    
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, frame.size.height - 10.0f - textFieldHeight, frame.size.width - 20.0f, textFieldHeight)];
    textField.backgroundColor = [UIColor clearColor];
    textField.textColor = [UIColor blackColor];
    textField.placeholder = @"我想...";
    textField.delegate = self;
    [self addSubview:textField];
}


#pragma mark DELEGATE


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *content = textField.text;
    
    if (content != [NSString stringWithFormat:@""] && content != NULL && content != nil) {
        
        if ([self.delegate respondsToSelector:@selector(didReturnText:)]) {
            [self.delegate didReturnText:content];
        }
    }
    
    [textField setText:@""];
    
    return YES;
}



@end
