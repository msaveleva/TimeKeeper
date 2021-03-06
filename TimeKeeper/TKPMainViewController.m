//
//  TKPViewController.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPMainViewController.h"
#import "TKPHeaderView.h"
#import "TKPCategory.h"
#import "TKPAppDelegate.h"
#import "TKPEditViewController.h"
#import "TKPStatisticsViewController.h"
#import "UIColor+CustomColors.h"

static NSString *const kCellIdentifier = @"categoryCell";
static NSString *const kEditViewControllerID = @"editViewController";
static NSString *const kStatisticsViewController = @"statisticsViewController";

@interface TKPMainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;
@property (weak, nonatomic) IBOutlet TKPHeaderView *headerView;
@property (strong, nonatomic) NSArray *categoryList;
@property (weak, nonatomic) NSString *timerTextForCell;
@property (strong, nonatomic) NSIndexPath *indexPathForRecordedCell;

@end

@implementation TKPMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.categoriesTableView.backgroundColor = [UIColor categoryCellBackgroundColor];
    
    //set header view mode
    self.categoriesTableView.backgroundColor = [UIColor categoryCellBackgroundColor];
    [self.headerView enableStandartMode];
    [[TKPCategoryManager sharedInstance] setDelegate:self];
    
    //remove header and footer
    self.categoriesTableView.tableHeaderView =
        [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.categoriesTableView.bounds.size.width, 1.0f)];
    self.categoriesTableView.tableFooterView =
        [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.categoriesTableView.bounds.size.width, 1.0f)];
    
    //register custom cell
    UINib *nib = [UINib nibWithNibName:@"TKPCategoryTableViewCell" bundle:nil];
    [self.categoriesTableView registerNib:nib forCellReuseIdentifier:kCellIdentifier];
    
    //setting up buttons
    [self.headerView.addCategoryButton addTarget:self
                                          action:@selector(addCategory:)
                                forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.statisticButton addTarget:self
                                        action:@selector(viewStatistics:)
                              forControlEvents:UIControlEventTouchUpInside];
    
    self.categoryList = [[TKPCategoryManager sharedInstance] loadCategories];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.categoryList = [[TKPCategoryManager sharedInstance] loadCategories];
    [self.categoriesTableView reloadData];
}

- (void)addCategory:(UIButton *)button
{
    TKPEditViewController *editViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:kEditViewControllerID];
    [self presentViewController:editViewController animated:YES completion:nil];
}

- (void)viewStatistics:(UIButton *)button
{
    TKPStatisticsViewController *statisticsViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:kStatisticsViewController];
    statisticsViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:statisticsViewController animated:YES completion:nil];
}

#pragma mark - Table View methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categoryList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKPCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                                     forIndexPath:indexPath];
    TKPCategory *category = [self.categoryList objectAtIndex:indexPath.row];
    [cell configureCellWithCategory:category delegate:self];
    NSString *currentCategoryName = [[TKPCategoryManager sharedInstance] currentCategoryName];
    TKPCategoryStatus status = [[TKPCategoryManager sharedInstance] status];
    if ([category.name isEqualToString:currentCategoryName] &&
        (status == TKPCategoryStatusRecording || status == TKPCategoryStatusPaused)) {
        cell.isCategoryTimeRecording = YES;
        cell.categoryTimePassLabel.text = self.timerTextForCell;
        [cell.pauseButton addTarget:self
                             action:@selector(pauseCategoryFromCell:)
                   forControlEvents:UIControlEventTouchUpInside];
    } else {
        cell.isCategoryTimeRecording = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKPCategoryStatus status = [[TKPCategoryManager sharedInstance] status];
    if (status == TKPCategoryStatusPaused || status == TKPCategoryStatusRecording) {
        [[TKPCategoryManager sharedInstance] stopCategory];
    }
    
    TKPCategoryTableViewCell *cell = (TKPCategoryTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.isCategoryTimeRecording = YES;
    cell.categoryTimePassLabel.text = @"";
    [[TKPCategoryManager sharedInstance] startCategory:[self.categoryList objectAtIndex:indexPath.row]];
    self.indexPathForRecordedCell = indexPath;
}

- (void)pauseCategoryFromCell:(id)sender
{
    [[TKPCategoryManager sharedInstance] pauseCategory];
}

#pragma mark - TKPEditDeleteProtocol methods

- (void)editCategory:(TKPCategory *)category
{
    TKPEditViewController *editViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:kEditViewControllerID];
    editViewController.editedCategory = category;
    [self presentViewController:editViewController animated:YES completion:nil];
}

- (void)deleteCategory:(TKPCategory *)category
{
    TKPAppDelegate *appDelegate = (TKPAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.managedObjectContext deleteObject:category];
    
    NSError *error;
    if (![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Can't delete category: %@", error);
    }
    
    self.categoryList = [[TKPCategoryManager sharedInstance] loadCategories];
    [self.categoriesTableView reloadData];
}

#pragma mark - TKPStopWatchUpdateDelegate

- (void)updateStopwatch:(NSString *)stopwatchValue
{
    self.timerTextForCell = stopwatchValue;
    if (self.indexPathForRecordedCell) {
        [self.categoriesTableView reloadRowsAtIndexPaths:@[self.indexPathForRecordedCell] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)stopCategoryTraking
{
    self.timerTextForCell = nil;
    self.indexPathForRecordedCell = nil;
    [self.categoriesTableView reloadData];
}

@end
