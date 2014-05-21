//
//  TKPCategoryTableViewCell.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKPCategoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryTypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *categoryIndicatorImageView;
@property (weak, nonatomic) IBOutlet UIView *categoryLabelsContentView;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;

@property (nonatomic) BOOL isEditing;
@property (nonatomic) BOOL isRemoving;

@end
