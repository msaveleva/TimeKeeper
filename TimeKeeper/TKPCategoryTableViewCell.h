//
//  TKPCategoryTableViewCell.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKPCategory.h"

@protocol TKPEditDeleteProtocol <NSObject>

- (void)editCategory:(TKPCategory *)category;
- (void)deleteCategory:(TKPCategory *)category;

@end

@interface TKPCategoryTableViewCell : UITableViewCell

@property (weak, nonatomic) id<TKPEditDeleteProtocol> delegate;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryTypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *categoryIndicatorImageView;
@property (weak, nonatomic) IBOutlet UIView *categoryLabelsContentView;
@property (weak, nonatomic) IBOutlet UILabel *categoryTimePassLabel;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

@property (nonatomic) BOOL isEditing;
@property (nonatomic) BOOL isRemoving;
/**
 in this mode you can't edit or remove categories, so when YES,
 swipes are inactive, and pause button shown
 */
@property (nonatomic) BOOL isCategoryTimeRecording;

- (void)hidePauseButton;
- (void)showPauseButton;
- (void)configureCellWithCategory:(TKPCategory *)category;

@end
