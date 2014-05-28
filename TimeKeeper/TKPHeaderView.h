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

//header view modes

//for main screen
- (void)enableStandartMode;

//for edit screen and main screen while creating new category
- (void)enableEditionMode;

//for statistic screen
- (void)enableStatisticMode;

@end
