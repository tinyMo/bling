//
//  BlingListView.m
//  bling
//
//  Created by 楼 彬 on 17/6/8.
//  Copyright (c) 2017年 lb1006. All rights reserved.
//

#import "BlingListView.h"
#import "DataBase.h"
#import "CustomCell.h"



#define BLINGLIST_IDENTIFER  @"blinglist_identifer"

@interface BlingListView ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

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
    self.blingListView.showsVerticalScrollIndicator = NO;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20.0f)];
    footView.backgroundColor = [UIColor clearColor];
    self.blingListView.tableFooterView = footView;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10.0f)];
    headerView.backgroundColor = [UIColor clearColor];
    self.blingListView.tableHeaderView = headerView;
    [self addSubview:self.blingListView];
    
    //输入数据界面
    InputView * inputView = [[InputView alloc] initWithFrame:CGRectMake(0, -44.0f, frame.size.width, 44.0f)];
    [self.blingListView addSubview:inputView];
    self.inputView = inputView;
}


//初始化今天的数据
- (void)initTadayData {
    
    self.dataArray = [NSMutableArray arrayWithArray:[DataBase sharedInstance].todaylistData];
}


- (void)respondtoEdit {
    
    
    self.blingListView.contentInset = UIEdgeInsetsMake(44.0f, 0, 0, 0);
    [self.inputView.textField becomeFirstResponder];
}


- (void)cancelEdit {
    
    self.blingListView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.inputView.textField resignFirstResponder];
    
    [self.inputView.textField setText:@""];
}


#pragma mark - DELEGATE


 
//UITableView delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:BLINGLIST_IDENTIFER];
    
    if (!cell) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BLINGLIST_IDENTIFER];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    
//    NSInteger row = (indexPath.row % 2);
//    
//    if (row == 0) {
//        
//        cell.backgroundColor = [UIColor lightGrayColor];
//    } else {
//        
//        cell.backgroundColor = [UIColor whiteColor];
//    }
    
    
    
    [cell updateText:[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.inputView.textField.text isEqualToString:@""]) {
        
        if ([self.delegate respondsToSelector:@selector(cancelEdit)]) {
            [self.delegate cancelEdit];
        }
    }
}



 
//UIScrollView delegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"offset = %f", scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y <= -44.0f) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -44.0f);
    }
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView.contentOffset.y == -44.0f) {
        
        if ([self.delegate respondsToSelector:@selector(startEdit)]) {
            [self.delegate startEdit];
        }
    }
}




#pragma mark - DATASOURCE


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * text = [self.dataArray objectAtIndex:indexPath.row];
    
    return [CustomCell cellHeight:text];
}


@end
