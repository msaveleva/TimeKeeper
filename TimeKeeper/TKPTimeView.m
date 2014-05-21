//
//  TKPTimeView.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPTimeView.h"
#import "UIColor+CustomColors.h"

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
        self.timerScrollViewConstraint.constant = 0;
    }
    return self;
}

@end
