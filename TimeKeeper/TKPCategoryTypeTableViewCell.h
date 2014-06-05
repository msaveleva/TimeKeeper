//
//  TKPCategoryTypeTableViewCell.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 28/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TKPTimeCategoryType) {
    TKPTimeCategoryTypeProductive,
    TKPTimeCategoryTypeNeutral,
    TKPTimeCategoryTypeUnproductive,
};

@interface TKPCategoryTypeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *indicatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeTypeLabel;

- (void)setTimeCategoryType:(TKPTimeCategoryType)type;

@end
