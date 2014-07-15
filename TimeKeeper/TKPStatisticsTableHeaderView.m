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

@end

@implementation TKPStatisticsTableHeaderView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TKPStatisticsTableHeaderView class]) owner:self options:nil] lastObject]];
    }
    
    self.contentView.backgroundColor = [UIColor categoryCellBackgroundColor];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TKPStatisticsTableHeaderView class]) owner:self options:nil] lastObject]];
    }
    
    self.contentView.backgroundColor = [UIColor categoryCellBackgroundColor];
    return self;
}


@end
