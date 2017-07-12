//
//  CustomCell.h
//  bling
//
//  Created by 楼 彬 on 2017/7/12.
//  Copyright © 2017年 lb1006. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell



+ (CGFloat)cellHeight:(NSString *)text;


- (void)updateText:(NSString *)text;


@end
