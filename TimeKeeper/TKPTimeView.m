//
//  TKPTimeView.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPTimeView.h"

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
    }
    return self;
}

- (instancetype)setUpTimeView
{
    TKPTimeView *timeView =
        [[[NSBundle mainBundle] loadNibNamed:@"TKPTimeView" owner:self options:nil] lastObject];
    
    if ([timeView isKindOfClass:[self class]]) {
        return timeView;
    } else {
        NSLog(@"An error has occured creating timeView!");
        return nil;
    }
}

@end
