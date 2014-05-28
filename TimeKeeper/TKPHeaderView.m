//
//  TKPHeaderView.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPHeaderView.h"
#import "UIColor+CustomColors.h"

static NSString * const kStandartTitle = @"Time Tracker";
static NSString * const kEditTitle = @"Edit Track";

@interface TKPHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *statisticButton;
@property (weak, nonatomic) IBOutlet UIButton *addCategoryButton;

@end

@implementation TKPHeaderView

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
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"TKPHeaderView" owner:self options:nil] lastObject]];
        
        //set colors
        self.contentView.backgroundColor = [UIColor headerViewBackground];
    }
    return self;
}

#pragma mark - Modes

- (void)enableStandartMode
{
    self.statisticButton.hidden = NO;
    self.addCategoryButton.hidden = NO;
    
    self.titleLabel.text = kStandartTitle;
}

- (void)enableEditionMode
{
    self.statisticButton.hidden = YES;
    self.addCategoryButton.hidden = YES;
    
    self.titleLabel.text = kEditTitle;
}

- (void)enableStatisticMode
{
    self.statisticButton.hidden = YES;
    self.addCategoryButton.hidden = YES;
    
    self.titleLabel.text = kStandartTitle;
}

#pragma mark - Button Actions

- (IBAction)addButtonPressed:(id)sender {
    
}

- (IBAction)showStatisticButtonPressed:(id)sender {
    
}


@end
