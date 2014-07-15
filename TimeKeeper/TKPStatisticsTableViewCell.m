//
//  TKPStatisticsTableViewCell.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 15/07/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPStatisticsTableViewCell.h"
#import "UIColor+CustomColors.h"

@interface TKPStatisticsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation TKPStatisticsTableViewCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor categoryCellBackgroundColor];
}

- (void)configureWithCategoryName:(NSString *)name andTime:(NSString *)time
{
    
}

@end
