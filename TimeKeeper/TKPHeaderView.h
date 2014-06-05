//
//  TKPHeaderView.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKPHeaderView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *statisticButton;
@property (weak, nonatomic) IBOutlet UIButton *addCategoryButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UIButton *categoryListButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

//header view modes

//for main screen
- (void)enableStandartMode;

//for edit screen and main screen while creating new category
- (void)enableEditionMode;

//for statistic screen
- (void)enableStatisticMode;

@end
