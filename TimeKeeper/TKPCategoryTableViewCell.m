//
//  TKPCategoryTableViewCell.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPCategoryTableViewCell.h"
#import "UIColor+CustomColors.h"

static CGFloat const kMaxMargin = 64.0f;
static CGFloat const kMinMargin = 0.0f;
static CGFloat const kAnimationSpeed = 0.3f;

@interface TKPCategoryTableViewCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftContentViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightContentViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pauseButtonWidthConstraint;

@property (strong, nonatomic) UISwipeGestureRecognizer *leftSwipeGesture;
@property (strong, nonatomic) UISwipeGestureRecognizer *rightSwipeGesture;
@property (strong, nonatomic) TKPCategory *currentCategory;

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
    self.isEditing = NO;
    self.isRemoving = NO;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.pauseButtonWidthConstraint.constant = 0.0f;
    
    //set colors
    self.editButton.backgroundColor = [UIColor editButtonCellColor];
    self.removeButton.backgroundColor = [UIColor removeButtonCellColor];
    self.categoryLabelsContentView.backgroundColor = [UIColor categoryCellBackgroundColor];
    
    self.leftContentViewConstraint.constant = kMinMargin;
    self.rightContentViewConstraint.constant = kMinMargin;
    [self layoutIfNeeded];
    
    //setting up gestures
    self.leftSwipeGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handleLeftSwipe:)];
    [self.leftSwipeGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    self.rightSwipeGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handleRightSwipe:)];
    [self.rightSwipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];

    self.isCategoryTimeRecording = NO;
    self.pauseButtonWidthConstraint.constant = kMaxMargin;
}

- (void)configureCellWithCategory:(TKPCategory *)category
{
    self.currentCategory = category;
    self.categoryNameLabel.text = self.currentCategory.name;
    [self setCategoryTimeTypeWithType:self.currentCategory.type.integerValue];
    
    self.leftContentViewConstraint.constant = kMinMargin;
    self.rightContentViewConstraint.constant = kMinMargin;
    [self layoutIfNeeded];
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
    } else {
        [UIView animateWithDuration:kAnimationSpeed animations:^{
            self.leftContentViewConstraint.constant = kMinMargin;
            [self layoutIfNeeded];
        } completion:^(BOOL isFinished){
            self.isEditing = NO;
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
    } else {
        [UIView animateWithDuration:kAnimationSpeed animations:^{
            self.rightContentViewConstraint.constant = kMinMargin;
            [self layoutIfNeeded];
        } completion:^(BOOL isFinished){
            self.isRemoving = NO;
        }];
    }
}

#pragma mark - Pause button

- (void)hidePauseButton
{
    if (!self.pauseButton.isHidden) {
        [UIView animateWithDuration:kAnimationSpeed animations:^{
            self.pauseButton.hidden = YES;
            self.pauseButton.alpha = 0;
        } completion:^(BOOL isFinished){
            //some completion
        }];
    }
}

- (void)showPauseButton
{
    if (self.pauseButton.isHidden) {
        [UIView animateWithDuration:kAnimationSpeed animations:^{
            self.pauseButton.hidden = NO;
            self.pauseButton.alpha = 1;
        } completion:^(BOOL isFinished){
            //some completion
        }];
    }
}

#pragma mark - Edit and remove actions

- (IBAction)editCategory:(id)sender {
    [self.delegate editCategory:self.currentCategory];
}

- (IBAction)removeCategory:(id)sender {
    [self.delegate deleteCategory:self.currentCategory];
}

#pragma mark - Category type

- (void)setCategoryTimeTypeWithType:(TKPCategoryType)type
{
    switch (type) {
        case TKPCategoryTypeProductiveTime:
            self.categoryTypeLabel.text = NSLocalizedString(@"productive.time", nil);
            self.categoryIndicatorImageView.image = [UIImage imageNamed:@"SmallGreenCircle"];
            break;
        case TKPCategoryTypeNeutralTime:
            self.categoryTypeLabel.text = NSLocalizedString(@"neutral.time", nil);
            self.categoryIndicatorImageView.image = [UIImage imageNamed:@"SmallBlueCircle"];
            break;
        case TKPCategoryTypeUnproductiveTime:
            self.categoryTypeLabel.text = NSLocalizedString(@"unproductive.time", nil);
            self.categoryIndicatorImageView.image = [UIImage imageNamed:@"SmallRedCircle"];
            break;
            
        default:
            break;
    }
}

#pragma mark - Category Recording Mode

- (void)setIsCategoryTimeRecording:(BOOL)isCategoryTimeRecording
{
    if (isCategoryTimeRecording) {
        self.categoryTimePassLabel.hidden = NO;
        [self showPauseButton];
        [self removeGestureRecognizer:self.leftSwipeGesture];
        [self removeGestureRecognizer:self.rightSwipeGesture];
    } else {
        [self hidePauseButton];
        self.categoryTimePassLabel.hidden = YES;
        [self addGestureRecognizer:self.leftSwipeGesture];
        [self addGestureRecognizer:self.rightSwipeGesture];
    }
}

@end
