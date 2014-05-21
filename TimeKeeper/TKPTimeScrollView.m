//
//  TKPTimeScrollView.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 21/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPTimeScrollView.h"
#import "UIColor+CustomColors.h"

@implementation TKPTimeScrollView

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
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"TKPTimeScrollView" owner:self options:nil] lastObject]];
        
        //set colors
        self.timeIntervalView.backgroundColor = [UIColor timeViewBackgroundColor];
    }
    return self;
}

@end
