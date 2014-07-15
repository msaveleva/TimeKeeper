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

@property (strong, nonatomic) NSArray *categoryList;


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
    self.chartSlices = [NSMutableArray arrayWithArray:@[@20, @20, @50]];
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
    
//    NSArray *array = [[TKPStatisticsManager sharedInstance] loadCategoriesForType:TKPCategoryTypeProductiveTime];
//    double time = [[TKPStatisticsManager sharedInstance] loadTimeForType:TKPCategoryTypeProductiveTime];
//    NSInteger result = [[TKPStatisticsManager sharedInstance] loadPercentsForType:TKPCategoryTypeProductiveTime];
//    double categorytime = [[TKPStatisticsManager sharedInstance] loadTimeForCategoryNamed:@"Manga"];
    //Привет, мусечка!
    
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
    //TODO: change when get real data
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: change when get real data
    return 2;
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
    headerInfo.persents = [NSString stringWithFormat:@"%d %%", percents];
    
    headerView.delegate = self;
    [headerView configureHeaderViewWithInfo:headerInfo];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKPStatisticsTableViewCell *cell = (TKPStatisticsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kStatisticsCellIdentifier];
    
    //TODO: implement
    
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
    //TODO: insert or delete rows for category type
}

@end
