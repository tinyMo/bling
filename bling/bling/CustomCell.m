//
//  CustomCell.m
//  bling
//
//  Created by 楼 彬 on 2017/7/12.
//  Copyright © 2017年 lb1006. All rights reserved.
//

#import "CustomCell.h"


@interface CustomCell ()

@property (nonatomic, weak) UILabel *CustomLabel;

@end



@implementation CustomCell


+ (CGFloat)cellHeight:(NSString *)text {
    
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:18.0f]};
    
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(kScreenWidth - 40.0f, 1000.0f)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dict
                                     context:nil];
    
    return rect.size.height + 28.0f;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initViews];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToEdit) name:kNotification_edit object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelEdit) name:kNotification_cancelEdit object:nil];
    }
    
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)updateText:(NSString *)text {
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:18.0f]};
    
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(kScreenWidth - 40.0f, 1000.0f)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dict
                                     context:nil];
    
    self.CustomLabel.frame = CGRectMake(20.0f, 0.0f, kScreenWidth - 40.0f, rect.size.height);
    self.CustomLabel.text = text;
}



#pragma mark - PRIVATE METHOD

- (void)initViews {
    
    UILabel * textLabel = [UILabel new];
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.font = [UIFont fontWithName:@"PingFang SC" size:18.0f];
    textLabel.textColor = kTextColor;
    [self addSubview:textLabel];
    self.CustomLabel = textLabel;
}


- (void)respondToEdit {
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.CustomLabel.alpha = 0.0f;
    }];
}

- (void)cancelEdit {
    
    self.CustomLabel.alpha = 1.0f;
}


@end
