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
static CGFloat kAnimationSpeed = 0.3f;

@interface TKPCategoryTableViewCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftContentViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightContentViewConstraint;

@property (strong, nonatomic) UISwipeGestureRecognizer *leftSwipeGesture;
@property (strong, nonatomic) UISwipeGestureRecognizer *rightSwipeGesture;

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
    self.isEditing = NO;
    self.isRemoving = NO;
    self.leftContentViewConstraint.constant = kMinMargin;
    self.rightContentViewConstraint.constant = kMinMargin;
    [self layoutIfNeeded];
    
    //setting up gestures
    self.leftSwipeGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handleLeftSwipe:)];
    [self.leftSwipeGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:self.leftSwipeGesture];
    
    self.rightSwipeGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handleRightSwipe:)];
    [self.rightSwipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:self.rightSwipeGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Edition mode animation

- (void)handleLeftSwipe:(id)sender
{
    if (!self.isEditing) {
        [UIView animateWithDuration:kAnimationSpeed animations:^{
            self.rightContentViewConstraint.constant = kMaxMargin;
            [self layoutIfNeeded];
        } completion:^(BOOL isFinished){
            self.isRemoving = YES;
        }];
    }
}

- (void)handleRightSwipe:(id)sender
{
    if (!self.isRemoving) {
        [UIView animateWithDuration:kAnimationSpeed animations:^{
            self.leftContentViewConstraint.constant = kMaxMargin;
            [self layoutIfNeeded];
        } completion:^(BOOL isFinished){
            self.isEditing = YES;
        }];
    }
    
}

@end
