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
#import "BlingListView.h"



@interface ViewController ()


@property(nonatomic, strong) InputView *inputView;
@property(nonatomic, weak) BlingListView *listView;


@end

@implementation ViewController


#pragma mark - PUBLIC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置参数
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //load views
    [self loadViews];
    
    
    //更多配置
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataRefreshNotifaction) name:kNotification_data_refresh object:nil];
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
    self.listView = blingListView;
}




- (void)btnAction
{
    ListViewController *listViewController = [[ListViewController alloc] init];
    listViewController.view.frame = self.view.bounds;
    [self.view addSubview:listViewController.view];
    
    [self presentViewController:listViewController animated:YES completion:^{

    }];
}


- (void)dataRefreshNotifaction
{
    [self.listView reloadTadayData];
}



#pragma mark DELEGATE


- (void)didReturnText:(NSString *)text
{
    [[DataBase sharedInstance] insertbling:text];
}


















@end
