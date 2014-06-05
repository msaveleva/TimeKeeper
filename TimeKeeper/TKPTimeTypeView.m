//
//  TKPTimeTypeView.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 02/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPTimeTypeView.h"

@implementation TKPTimeTypeView

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
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"TKPTimeTypeView" owner:self options:nil] lastObject]];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

@end
