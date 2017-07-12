//
//  BlingListView.h
//  bling
//
//  Created by 楼 彬 on 17/6/8.
//  Copyright (c) 2017年 lb1006. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InputView.h"


@protocol BlingListViewDelegate <NSObject>


- (void)startEdit;
- (void)cancelEdit;


@end




@interface BlingListView : UIView


@property (nonatomic, weak) InputView * inputView;
@property (nonatomic, weak) id<BlingListViewDelegate> delegate;


- (void)reloadTadayData;

- (void)respondtoEdit;
- (void)cancelEdit;


@end
