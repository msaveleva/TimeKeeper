//
//  TKPStatisticsTableViewCell.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 10/07/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPStatisticsTableViewCell.h"
#import "UIColor+CustomColors.h"

@implementation TKPStatisticsTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor categoryCellBackgroundColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
