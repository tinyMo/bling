//
//  CustomLine.m
//  bling
//
//  Created by 楼 彬 on 17/6/30.
//  Copyright (c) 2017年 lb1006. All rights reserved.
//

#import "CustomLine.h"


@interface CustomLine ()


@end


@implementation CustomLine


- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 228.0f/255.0f, 228.0 / 255.0, 228.0 / 255.0, 0.8f);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 20.0f, 0);  //起点坐标
    CGContextAddLineToPoint(context, self.frame.size.width, 0);   //终点坐标
    
    CGContextStrokePath(context);
}



+ (CustomLine *)getOne:(CGRect)frame;
{
    CustomLine *line = [[CustomLine alloc] initWithFrame:frame];
    line.backgroundColor = [UIColor clearColor];
    
    return line;
}


#pragma mark - Getter & Setter

- (void)setLineColor:(UIColor *)lineColor {
    
    _lineColor = lineColor;
    
    [self setNeedsDisplay];
}


@end
