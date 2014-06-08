//
//  TKPTimeScrollView.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 21/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPTimeScrollView.h"
#import "UIColor+CustomColors.h"
#import "UIFont+CustomFonts.h"
#import "TKPTimerManager.h"

static CGSize const kTimeButtonSize = { 68.0f, 53.0f };

@interface TKPTimeScrollView ()

@property (nonatomic, strong) UIView *scrollViewContentView;
@property (nonatomic, strong) NSArray *timeIntervals;

@end

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
        
        //set timeIntervals
        self.timeIntervals = @[@"05", @"10", @"15", @"30", @"45", @"60"];
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView
{
    if (!self.scrollViewContentView) {
        self.scrollViewContentView =
            [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                    0.0f,
                                                    kTimeButtonSize.width * [self.timeIntervals count],
                                                    kTimeButtonSize.height)];
        [self.timeIntervalScrollView addSubview:self.scrollViewContentView];
        self.timeIntervalScrollView.contentSize = self.scrollViewContentView.frame.size;
        
        CGFloat leftMargin = 0.0f;
        for (NSString *title in self.timeIntervals) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(leftMargin, 0.0f, kTimeButtonSize.width, kTimeButtonSize.height);
            [button setTitle:title forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont mediumSystemFontOfSize:42.0f];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.scrollViewContentView addSubview:button];
            leftMargin += kTimeButtonSize.width;
            
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)buttonPressed:(UIButton *)button
{
    NSUInteger time = [button.titleLabel.text integerValue];
    [[TKPTimerManager sharedManager] startTimerWithTime:time];
    
    UIAlertView *timerAlert = [[UIAlertView alloc] initWithTitle:@"Timer was set"
                                                         message:@""
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [timerAlert show];
}

@end
