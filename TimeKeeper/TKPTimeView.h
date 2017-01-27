//
//  TKPTimeView.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKPTimeScrollView;

@interface TKPTimeView : UIView

@property (weak, nonatomic) IBOutlet UIButton *clockButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet TKPTimeScrollView *timerScrollView;
@property (weak, nonatomic) IBOutlet UIView *timerView;
@property (weak, nonatomic) IBOutlet UIView *timerAndButtonView;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryStopwatchLabel;

- (void)clearTimeView;

@end
