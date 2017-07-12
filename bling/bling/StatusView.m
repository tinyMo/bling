//
//  StatusView.m
//  bling
//
//  Created by 楼 彬 on 17/6/30.
//  Copyright (c) 2017年 lb1006. All rights reserved.
//

#import "StatusView.h"
#import "CustomLine.h"




@implementation StatusView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initViews:frame];
        
    }
    
    return self;

}


#pragma mark  PRIVATE METHOD

- (void)initViews:(CGRect)frame
{
    //设置StatusView 属性
    self.backgroundColor = [UIColor whiteColor];
    
    
    
    CGFloat dateLabelHeight = 20.0f;
    
    //获取今天日期
    NSDate * date = [NSDate date];
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    unsigned flag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents * dateComponents = [calendar components:flag fromDate:date];
    
    //月、日 星期几
    long month = dateComponents.month;
    long day = dateComponents.day;
    
    NSArray * weekArray = [NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    long weekday = dateComponents.weekday;
    NSString * todayWeek = [weekArray objectAtIndex:weekday];
    
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, frame.size.height - 20.0f - dateLabelHeight, frame.size.width, dateLabelHeight)];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    dateLabel.text = [NSString stringWithFormat:@"%ld月%ld日 %@", month, day, todayWeek];
    dateLabel.textColor = [UIColor grayColor];
    [self addSubview:dateLabel];
    
    
    //加入 Custom line
    CustomLine *line = [CustomLine getOne:CGRectMake(0, frame.size.height - 1.0f, frame.size.width, 1.0f)];
    [self addSubview:line];
    
}




@end
