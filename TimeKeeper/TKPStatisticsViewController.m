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

@interface TKPStatisticsViewController ()

@property (weak, nonatomic) IBOutlet TKPHeaderView *headerView;
@property (weak, nonatomic) IBOutlet XYPieChart *pieChart;
@property (strong, nonatomic) NSMutableArray *chartSlices;
@property (strong, nonatomic) NSArray *chartSliceColors;


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
    self.chartSlices = [NSMutableArray arrayWithArray:@[@20, @20, @50, @60]];
    self.chartSliceColors =[NSArray arrayWithObjects:
                            [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                            [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                            [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                            [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],nil];
    
    self.pieChart.delegate = self;
    self.pieChart.dataSource = self;
    [self.pieChart setShowPercentage:NO];
    [self.pieChart setPieBackgroundColor:[UIColor categoryCellBackgroundColor]];	//optional
    [self.pieChart setLabelRadius:50.0f];
    [self.pieChart setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
    [self.pieChart setStartPieAngle:M_PI_2];
    [self.pieChart setAnimationSpeed:1.0];
    [self.pieChart setUserInteractionEnabled:NO];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.pieChart reloadData];
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

@end