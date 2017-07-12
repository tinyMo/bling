//
//  ListViewController.m
//  bling
//
//  Created by 楼 彬 on 17/6/7.
//  Copyright (c) 2017年 lb1006. All rights reserved.
//

#import "ListViewController.h"
#import "DataBase.h"

#define IDENTIFER   @"identifer"

@interface ListViewController ()

@property (nonatomic, strong) UITableView *ListView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ListViewController

#pragma mark - PUBLIC METHOD

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置参数
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.ListView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.ListView.backgroundColor = [UIColor whiteColor];
    self.ListView.delegate = self;
    self.ListView.dataSource = self;
    [self.view addSubview:self.ListView];
    
    
    self.dataArray = [[DataBase sharedInstance] obtainBlings];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - PRIVATE METHOD



#pragma mark - UITABLEVIEW DELEGATE

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0f;
}



#pragma mark - UITABLEVIEW DATASOURCE




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFER];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDENTIFER];
        
    }
    
    [cell.textLabel setText:[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;

}
























@end
