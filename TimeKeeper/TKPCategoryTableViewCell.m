//
//  TKPCategoryTableViewCell.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPCategoryTableViewCell.h"

static CGFloat const kMaxMargin = 64.0f;
static CGFloat const kMinMargin = 0.0f;

@interface TKPCategoryTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftContentViewContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightContentViewContraint;

@end

@implementation TKPCategoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    self.leftContentViewContraint.constant = kMinMargin;
    self.rightContentViewContraint.constant = kMinMargin;
    [self layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
