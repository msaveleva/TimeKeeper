//
//  TKPTimeView.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPTimeView.h"
#import "UIColor+CustomColors.h"

static CGFloat const kAnimationSpeed = 0.3f;
static CGFloat const kTimerAndButtonView = 256.0f;

@interface TKPTimeView ()

@property (nonatomic) BOOL isSettingAlarm;

@end

@implementation TKPTimeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"TKPTimeView" owner:self options:nil] lastObject]];
        
        //set colors
        self.timerScrollView.backgroundColor = [UIColor timeViewBackgroundColor];
        self.timerView.backgroundColor = [UIColor timeViewBackgroundColor];
        self.clockButton.backgroundColor = [UIColor timeViewButtonsColor];
        self.pauseButton.backgroundColor = [UIColor timeViewButtonsColor];
        
        //hide scrollView
        self.isSettingAlarm = NO;
        
    }
    return self;
}

- (IBAction)setAlarm:(id)sender {
    if (!self.isSettingAlarm) {
        [UIView animateWithDuration:kAnimationSpeed animations:^{
            self.timerAndButtonView.frame =
                UIEdgeInsetsInsetRect(self.timerAndButtonView.frame, UIEdgeInsetsMake(0.0f,
                                                                                      kTimerAndButtonView,
                                                                                      0.0f,
                                                                                      0.0f));
            [self layoutIfNeeded];
        } completion:^(BOOL isFinished){
            self.isSettingAlarm = YES;
        }];
    } else {
        [UIView animateWithDuration:kAnimationSpeed animations:^{
            self.timerAndButtonView.frame =
            UIEdgeInsetsInsetRect(self.timerAndButtonView.frame, UIEdgeInsetsMake(0.0f,
                                                                                  -kTimerAndButtonView,
                                                                                  0.0f,
                                                                                  0.0f));
            [self layoutIfNeeded];
        } completion:^(BOOL isFinished){
            self.isSettingAlarm = NO;
        }];
    }
}

@end
