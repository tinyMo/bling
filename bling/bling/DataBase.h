//
//  DataBase.h
//  bling
//
//  Created by 楼 彬 on 17/6/6.
//  Copyright (c) 2017年 lb1006. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>

@interface DataBase : NSObject


@property(nonatomic, strong) FMDatabase *fmdb;

@property(nonatomic, strong) NSMutableArray * todaylistData;



+ (instancetype)sharedInstance;



- (void)insertbling:(NSString *)bling;

//获得所有blings 数据
- (NSMutableArray *)obtainBlings;


//获得今天blings 数据
- (NSMutableArray *)obtainTodayBlings;

@end
