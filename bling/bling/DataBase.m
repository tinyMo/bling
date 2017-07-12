//
//  DataBase.m
//  bling
//
//  Created by 楼 彬 on 17/6/6.
//  Copyright (c) 2017年 lb1006. All rights reserved.
//

#import "DataBase.h"


@interface DataBase ()


@end



static DataBase *_database;


@implementation DataBase


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _database = [super allocWithZone:zone];
    });
    
    return _database;
}


+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _database = [[self alloc] init];
        
        [_database initFMDB];
        
    });
    
    return _database;
}


- (id)copyWithZone:(NSZone *)zone
{
    return _database;
}


- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _database;
}



#pragma mark - PUBLIC METHOD


- (NSMutableArray *)obtainTodayBlings
{
    
    return self.todaylistData;

}


- (NSMutableArray *)obtainBlings
{
    return self.todaylistData;
}


//向数据库插入1条数据
- (void)insertbling:(NSString *)bling
{
    if (bling == [NSString stringWithFormat:@""] || bling == nil || bling == NULL) {
        
        //可以通知插入数据失败！
        
        return;
    }
    
    
    
    if ([self.fmdb open]) {
        
        
        
        [self.fmdb executeUpdate:@"INSERT INTO bling(blingText) VALUES(?)", bling];
        
        
        //更新今天的数据到内存
        [self refreshTodayBlings];
    }
}






#pragma mark  - PRIVATE METHOD


//对象初始化，只调用1次
- (void)initFMDB
{
    
    //数据表
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *pathname = [doc stringByAppendingPathComponent:@"bling.sqlite"];
    //获取数据库文件路径
    
    FMDatabase *paramfmdb = nil;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:pathname])
    {
        //已经有数据图表存在
        paramfmdb = [FMDatabase databaseWithPath:pathname];
        
        [paramfmdb open];
    }
    else
    {
        paramfmdb = [FMDatabase databaseWithPath:pathname];
        
        if ([paramfmdb open]) {
            
            [paramfmdb executeUpdate:@"CREATE TABLE IF NOT EXISTS bling(num INTEGER PRIMARY KEY AUTOINCREMENT, time NOT NULL DEFAULT CURRENT_TIMESTAMP, blingText TEXT NOT NULL)"];
        }

    }
    
    
    self.fmdb = paramfmdb;

}


//重新初始化今天的全部blings，通知相关对象
- (void)refreshTodayBlings
{
    if (_todaylistData == nil) {
        return;
    }
    
    
    [self.todaylistData removeAllObjects];
    
    if ([self.fmdb open]) {
        
        FMResultSet *result = [self.fmdb executeQuery:@"SELECT blingText FROM bling WHERE strftime('%m-%d','now','localtime') = strftime('%m-%d',time) ORDER BY time desc"];
        
        while ([result next]) {
            
            NSString *bling = [result stringForColumn:@"blingText"];
            
            if (bling != [NSString stringWithFormat:@""] && bling != nil) {
                [self.todaylistData addObject:bling];
            }
        }
    }
    
    //通知相关对象，更新数据
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_data_refresh object:nil];
}


#pragma mark - GETTER & SETTER

- (NSMutableArray *)todaylistData
{
    if (_todaylistData == nil) {
        _todaylistData = [NSMutableArray array];
        
        //初始化今天的数据
        [self refreshTodayBlings];
    }
    
    return _todaylistData;
}





@end
