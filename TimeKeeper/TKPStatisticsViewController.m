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
#import "TKPStatisticsTableViewCell.h"
#import "TKPAppDelegate.h"
#import "TKPCategory.h"
#import "TKPTimeAndDate.h"
#import "TKPCategoryManager.h"

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
    
    //cells
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([TKPStatisticsTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kStatisticsCellIdentifier];
    
    //loading categories
    self.categoryList = [[TKPCategoryManager sharedInstance] loadCategories];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.pieChart reloadData];
}

#pragma mark - TableView delegte & data source methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKPStatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStatisticsCellIdentifier];
    
    return cell;
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

@end
