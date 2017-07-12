//
//  InputView.h
//  bling
//
//  Created by 楼 彬 on 17/6/7.
//  Copyright (c) 2017年 lb1006. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol InputViewDelegate <NSObject>


@optional

- (void)didReturnText:(NSString *)text;


@end




@interface InputView : UIView<UITextFieldDelegate>


@property(nonatomic, weak) id<InputViewDelegate> delegate;
@property (nonatomic, weak) UITextField * textField;





@end







