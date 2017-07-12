//
//  BlingListView.m
//  bling
//
//  Created by 楼 彬 on 17/6/8.
//  Copyright (c) 2017年 lb1006. All rights reserved.
//

#import "BlingListView.h"
#import "DataBase.h"


#define BLINGLIST_IDENTIFER  @"blinglist_identifer"

@interface BlingListView ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *blingListView;
@property(nonatomic, strong) NSMutableArray *dataArray;


@end



@implementation BlingListView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //初始化数据
        [self initTadayData];
        
        
        [self initBlingListView:frame];
    }
    
    return self;
}


//重新从数据库更新今天的所有数据
- (void)reloadTadayData
{
    [self.dataArray removeAllObjects], self.dataArray = nil;
    
    self.dataArray = [NSMutableArray arrayWithArray:[DataBase sharedInstance].todaylistData];
    [self.blingListView reloadData];
}



#pragma mark - PRIVATE METHOD

- (void)initBlingListView:(CGRect)frame
{
    //设置基本属性
    self.layer.masksToBounds = YES;
    
    
    //数据列表
    self.blingListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.blingListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.blingListView.layer.masksToBounds = YES;
    self.blingListView.delegate = self;
    self.blingListView.dataSource = self;
    self.blingListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 20.0f)];
    [self addSubview:self.blingListView];
    
    //输入数据界面
    InputView * inputView = [[InputView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44.0f)];
    self.blingListView.tableHeaderView = inputView;
    self.inputView = inputView;
}


//初始化今天的数据
- (void)initTadayData
{
    self.dataArray = [NSMutableArray arrayWithArray:[DataBase sharedInstance].todaylistData];
}





#pragma mark - DELEGATE


 
//UITableView delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BLINGLIST_IDENTIFER];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BLINGLIST_IDENTIFER];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell.textLabel setText:[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}



 
//UIScrollView delegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}




#pragma mark - DATASOURCE


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0f;
}


@end
