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
        [self enableStandartMode];
        
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
    self.cancelButton.hidden = YES;
    self.applyButton.hidden = YES;
    self.categoryListButton.hidden = YES;
    self.settingsButton.hidden = YES;
    
    self.titleLabel.text = kStandartTitle;
}

- (void)enableEditionMode
{
    self.statisticButton.hidden = YES;
    self.addCategoryButton.hidden = YES;
    self.cancelButton.hidden = NO;
    self.applyButton.hidden = NO;
    self.categoryListButton.hidden = YES;
    self.settingsButton.hidden = YES;
    
    self.titleLabel.text = kEditTitle;
}

- (void)enableStatisticMode
{
    self.statisticButton.hidden = YES;
    self.addCategoryButton.hidden = YES;
    self.cancelButton.hidden = YES;
    self.applyButton.hidden = YES;
    self.categoryListButton.hidden = NO;
    //TODO: enable when add settings
    self.settingsButton.hidden = YES;
    
    self.titleLabel.text = kStandartTitle;
}

#pragma mark - Button Actions

- (IBAction)addButtonPressed:(id)sender {
    
}

- (IBAction)showStatisticButtonPressed:(id)sender {
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    
}

- (IBAction)applyButtonPressed:(id)sender {
    
}

- (IBAction)categoryListButtonPressed:(id)sender {
    
}

- (IBAction)settingsButtonPressed:(id)sender {
    
}
@end
