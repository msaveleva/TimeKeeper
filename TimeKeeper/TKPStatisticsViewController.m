//
//  TKPStatisticsViewController.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 13/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPStatisticsViewController.h"
#import "TKPHeaderView.h"
#import "UIColor+CustomColors.h"
#import "TKPAppDelegate.h"
#import "TKPCategory.h"
#import "TKPTimeAndDate.h"
#import "TKPCategoryManager.h"
#import "TKPStatisticsManager.h"
#import "TKPHeaderInfo.h"
#import "TKPStatisticsTableViewCell.h"

static NSString *const kStatisticsCellIdentifier = @"statisticsCell";

@interface TKPStatisticsViewController ()

@property (weak, nonatomic) IBOutlet TKPHeaderView *headerView;
@property (weak, nonatomic) IBOutlet XYPieChart *pieChart;
@property (strong, nonatomic) NSMutableArray *chartSlices;
@property (strong, nonatomic) NSArray *chartSliceColors;
@property (weak, nonatomic) IBOutlet UIView *percentageBackground;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

@property (strong, nonatomic) NSArray *categoryList;

//model data
@property (strong, nonatomic) NSArray *productiveCategories;
@property (strong, nonatomic) NSArray *neutralCategories;
@property (strong, nonatomic) NSArray *unproductiveCategories;

@end

@implementation TKPStatisticsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.headerView enableStatisticMode];
    self.view.backgroundColor = [UIColor categoryCellBackgroundColor];
    
    //configure pieChart
    self.chartSlices = [NSMutableArray new];
    self.chartSliceColors = @[[UIColor productiveColor],
                              [UIColor neutralColor],
                              [UIColor unproductiveColor]];
    
    self.pieChart.delegate = self;
    self.pieChart.dataSource = self;
    [self.pieChart setShowPercentage:NO];
    [self.pieChart setPieBackgroundColor:[UIColor categoryCellBackgroundColor]];	//optional
    [self.pieChart setLabelRadius:0.0f];
    [self.pieChart setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
    [self.pieChart setStartPieAngle:M_PI_2];
    [self.pieChart setAnimationSpeed:1.0];
    [self.pieChart setUserInteractionEnabled:NO];
    
    [self.percentageBackground.layer setCornerRadius:60.0f];
    self.percentageBackground.backgroundColor = [UIColor categoryCellBackgroundColor];
    
    [self.headerView.categoryListButton addTarget:self
                                           action:@selector(returnToMainScree:)
                                 forControlEvents:UIControlEventTouchUpInside];
    
    //colors
    self.tableView.backgroundColor = [UIColor categoryCellBackgroundColor];
    
    //loading categories
    self.categoryList = [[TKPCategoryManager sharedInstance] loadCategories];
    
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([TKPStatisticsTableViewCell class]) bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:kStatisticsCellIdentifier];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.pieChart reloadData];
}

#pragma mark - TableView delegte & data source methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    switch (section) {
        case TKPCategoryTypeProductiveTime:
            numberOfRows = [self.productiveCategories count];
            break;
        case TKPCategoryTypeNeutralTime:
            numberOfRows = [self.neutralCategories count];
            break;
        case TKPCategoryTypeUnproductiveTime:
            numberOfRows = [self.unproductiveCategories count];
            break;
    }
    
    return numberOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 75.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //TODO: change when get real data
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TKPStatisticsTableHeaderView *headerView = [[TKPStatisticsTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 75)];
    double time = [[TKPStatisticsManager sharedInstance] loadTimeForType:section];
    NSInteger percents = [[TKPStatisticsManager sharedInstance] loadPercentsForType:section];
    NSString *timeStringRepresentation = [self makeTimeStringFromInterval:time];
    
    TKPHeaderInfo *headerInfo = [TKPHeaderInfo new];
    headerInfo.type = section;
    headerInfo.spentTime = timeStringRepresentation;
    headerInfo.persents = [NSString stringWithFormat:@"%ld%%", (long)percents];
    
    if (section == 0) {
        self.percentLabel.text = headerInfo.persents;
    }
    
    [self.chartSlices addObject:@(percents)];
    
    headerView.delegate = self;
    [headerView configureHeaderViewWithInfo:headerInfo section:section];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKPStatisticsTableViewCell *cell = (TKPStatisticsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kStatisticsCellIdentifier];
    
    NSArray *usedArray;
    switch (indexPath.section) {
        case TKPCategoryTypeProductiveTime:
            usedArray = self.productiveCategories;
            break;
        case TKPCategoryTypeNeutralTime:
            usedArray = self.neutralCategories;
            break;
        case TKPCategoryTypeUnproductiveTime:
            usedArray = self.unproductiveCategories;
            break;
    }
    
    TKPCategory *category = [usedArray objectAtIndex:indexPath.row];
    double categoryTime = [[TKPStatisticsManager sharedInstance] loadTimeForCategoryNamed:category.name];
    NSString *categoryTimeStringRepresentation = [self makeTimeStringFromInterval:categoryTime];
    [cell configureWithCategoryName:category.name andTime:categoryTimeStringRepresentation];
    
    return cell;
}

#pragma mark - Data translates

- (NSString *)makeTimeStringFromInterval:(double)interval
{
    int timeInterval = (int)interval;
    int seconds = timeInterval % 60;
    int minutes = (timeInterval / 60) % 60;
    int hours = timeInterval / 3600;
    
    NSString *result = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    
    return  result;
}

#pragma mark - PieChart delegete & data source methods

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.chartSlices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.chartSlices objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [self.chartSliceColors objectAtIndex:index];
}

#pragma mark - Header view navigation

- (void)returnToMainScree:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table Header View methods

- (void)listWasUnscrolled:(BOOL)isUnscrolled forSection:(NSInteger)section
{
    if (isUnscrolled) {
        NSArray *usedArray;
        switch (section) {
            case TKPCategoryTypeProductiveTime:
                self.productiveCategories = [[TKPStatisticsManager sharedInstance] loadCategoriesForType:TKPCategoryTypeProductiveTime];
                usedArray = self.productiveCategories;
                break;
            case TKPCategoryTypeNeutralTime:
                self.neutralCategories = [[TKPStatisticsManager sharedInstance] loadCategoriesForType:TKPCategoryTypeNeutralTime];
                usedArray = self.neutralCategories;
                break;
            case TKPCategoryTypeUnproductiveTime:
                self.unproductiveCategories = [[TKPStatisticsManager sharedInstance] loadCategoriesForType:TKPCategoryTypeUnproductiveTime];
                usedArray = self.unproductiveCategories;
                break;
        }
        
        NSInteger numberOfRows = [usedArray count];
        NSMutableArray *indexPaths = [NSMutableArray new];
        for (int i = 0; i < numberOfRows; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            [indexPaths addObject:indexPath];
        }
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:YES];
        [self.tableView endUpdates];
    } else {
        NSInteger numberOfRows = 0;
        switch (section) {
            case TKPCategoryTypeProductiveTime:
                numberOfRows = [self.productiveCategories count];
                self.productiveCategories = nil;
                break;
            case TKPCategoryTypeNeutralTime:
                numberOfRows = [self.neutralCategories count];
                self.neutralCategories = nil;
                break;
            case TKPCategoryTypeUnproductiveTime:
                numberOfRows = [self.unproductiveCategories count];
                self.unproductiveCategories = nil;
                break;
        }
        
        NSMutableArray *indexPaths = [NSMutableArray new];
        for (int i = 0; i < numberOfRows; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            [indexPaths addObject:indexPath];
        }
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:YES];
        [self.tableView endUpdates];
    }
}

@end
