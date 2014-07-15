//
//  TKPStatisticsTableViewCell.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 10/07/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPStatisticsTableHeaderView.h"
#import "UIColor+CustomColors.h"

@interface TKPStatisticsTableHeaderView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryIndicator;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *persentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/**
 Indicates if content of section under this headerView should be visible.
 Default is NO
 */
@property (nonatomic) BOOL isUnscroll;
@property (nonatomic) NSInteger section;

//gestures
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

@end

@implementation TKPStatisticsTableHeaderView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TKPStatisticsTableHeaderView class]) owner:self options:nil] lastObject]];
    }
    
    [self initialize];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TKPStatisticsTableHeaderView class]) owner:self options:nil] lastObject]];
    }
    
    [self initialize];
    return self;
}

- (void)initialize
{
    self.contentView.backgroundColor = [UIColor categoryCellBackgroundColor];
    self.isUnscroll = NO;
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self.contentView addGestureRecognizer:self.tapGesture];
}

//TODO: add all objects for headerView configuration
- (void)configureWithSection:(NSInteger)section
{
    self.section = section;
}

#pragma mark - Gestures

- (void)onTap:(id)sender
{
    self.isUnscroll = !self.isUnscroll;
    [self.delegate listWasUnscrolled:self.isUnscroll forSection:self.section];
}

@end
