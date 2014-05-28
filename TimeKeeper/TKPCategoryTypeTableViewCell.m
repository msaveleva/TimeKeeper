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
    [self setTimeCategoryType:TKPTimeCategoryTypeProductive];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTimeCategoryType:(TKPTimeCategoryType)type
{
    switch (type) {
        case TKPTimeCategoryTypeProductive:
            [self.indicatorImageView setImage:[UIImage imageNamed:kProductiveIndicator]];
            break;
        case TKPTimeCategoryTypeNeutral:
            [self.indicatorImageView setImage:[UIImage imageNamed:kNeutralIndicator]];
            break;
        case TKPTimeCategoryTypeUnproductive:
            [self.indicatorImageView setImage:[UIImage imageNamed:kNeutralIndicator]];
            break;
        default:
            break;
    }
    
    self.timeTypeLabel.text = [self nameForType:type];
}

- (NSString *)nameForType:(TKPTimeCategoryType)type
{
    switch (type) {
        case TKPTimeCategoryTypeProductive:
            return @"Productive time";
            break;
        case TKPTimeCategoryTypeNeutral:
            return @"Neutral time";
            break;
        case TKPTimeCategoryTypeUnproductive:
            return @"Unproductive time";
            break;
        default:
            break;
    }
}

@end
