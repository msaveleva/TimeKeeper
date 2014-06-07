//
//  TKPCategoryTypeTableViewCell.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 28/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPCategoryTypeTableViewCell.h"
#import "UIColor+CustomColors.h"

static NSString * const kProductiveIndicator = @"BigGreenCircle";
static NSString * const kNeutralIndicator = @"BigBlueCircle";
static NSString * const kUnproductiveIndicator = @"BigRedCircle";

@implementation TKPCategoryTypeTableViewCell

- (void)awakeFromNib
{
    //set colors
    self.backgroundColor = [UIColor categoryCellBackgroundColor];
    [self setTimeCategoryType:TKPCategoryTypeProductiveTime];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTimeCategoryType:(TKPCategoryType)type
{
    switch (type) {
        case TKPCategoryTypeProductiveTime:
            [self.indicatorImageView setImage:[UIImage imageNamed:kProductiveIndicator]];
            break;
        case TKPCategoryTypeNeutralTime:
            [self.indicatorImageView setImage:[UIImage imageNamed:kNeutralIndicator]];
            break;
        case TKPCategoryTypeUnproductiveTime:
            [self.indicatorImageView setImage:[UIImage imageNamed:kUnproductiveIndicator]];
            break;
        default:
            break;
    }
    
    self.timeTypeLabel.text = [self nameForType:type];
}

- (NSString *)nameForType:(TKPCategoryType)type
{
    switch (type) {
        case TKPCategoryTypeProductiveTime:
            return @"Productive time";
            break;
        case TKPCategoryTypeNeutralTime:
            return @"Neutral time";
            break;
        case TKPCategoryTypeUnproductiveTime:
            return @"Unproductive time";
            break;
        default:
            break;
    }
}

@end
