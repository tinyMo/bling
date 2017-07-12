//
//  ViewController.m
//  bling
//
//  Created by 楼 彬 on 17/6/6.
//  Copyright (c) 2017年 lb1006. All rights reserved.
//

#import "ViewController.h"
#import "ListViewController.h"
#import "DataBase.h"
#import "StatusView.h"


typedef NS_ENUM(NSInteger, BlingListStatus) {
    statusNormal,
    statusEdit
};




@interface ViewController ()


@property(nonatomic, weak) BlingListView *listView;

@property(nonatomic) BlingListStatus blingStatus;


@end





@implementation ViewController



- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.blingStatus = statusNormal;
        
        //通知注册
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataRefreshNotifaction) name:kNotification_data_refresh object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    }

    
    return self;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置参数
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //load views
    [self loadViews];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (BOOL)prefersStatusBarHidden {
//    
//    return YES;
//}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - PRIVATE


- (void)loadViews
{
    CGRect viewFrame = self.view.frame;
    
    //StatusView 高度
    CGFloat statusViewHeight = 80.0f;
    
    StatusView * stView = [[StatusView alloc] initWithFrame:CGRectMake(0, 0, viewFrame.size.width, statusViewHeight)];
    [self.view addSubview:stView];
    
    
    //今天的数据
    BlingListView *blingListView = [[BlingListView alloc] initWithFrame:CGRectMake(0, statusViewHeight, viewFrame.size.width, viewFrame.size.height - statusViewHeight)];
    [self.view addSubview:blingListView];
    blingListView.inputView.delegate = self;
    blingListView.delegate = self;
    self.listView = blingListView;
}



#pragma mark - NOTIFICATION


- (void)dataRefreshNotifaction {
    
    [self.listView reloadTadayData];
}


- (void)keyboardWillHide {
    
    [self cancelEdit];
}



#pragma mark DELEGATE


- (void)didReturnText:(NSString *)text {
    
    [[DataBase sharedInstance] insertbling:text];
    
    [self cancelEdit];
}


- (void)startEdit {
    
    if (self.blingStatus == statusNormal) {
        
        self.blingStatus = statusEdit;
        
        [self.listView respondtoEdit];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_edit object:nil];
    }
}

- (void)cancelEdit {
    
    if (self.blingStatus == statusEdit) {
        
        self.blingStatus = statusNormal;
        
        [self.listView cancelEdit];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_cancelEdit object:nil];
    }
}














@end
