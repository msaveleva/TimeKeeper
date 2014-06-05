//
//  TKPEditNameTableViewCell.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 28/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPEditNameTableViewCell.h"
#import "UIColor+CustomColors.h"

@implementation TKPEditNameTableViewCell

- (void)awakeFromNib
{
    //set color
    self.backgroundColor = [UIColor categoryCellBackgroundColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
