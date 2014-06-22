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
    self.pieChart.delegate = self;
    self.pieChart.dataSource = self;
    [self.pieChart setShowPercentage:NO];
    
    [self.pieChart setStartPieAngle:M_PI_2];	//optional
    [self.pieChart setAnimationSpeed:1.0];	//optional
    [self.pieChart setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];	//optional
    [self.pieChart setLabelColor:[UIColor blackColor]];	//optional, defaults to white
    [self.pieChart setLabelShadowColor:[UIColor blackColor]];	//optional, defaults to none (nil)
    [self.pieChart setLabelRadius:160];	//optional
    [self.pieChart setShowPercentage:YES];	//optional
    [self.pieChart setPieBackgroundColor:[UIColor greenColor]];	//optional
}

#pragma mark - PieChart delegete & data source methods

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return 2;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    CGFloat value = 0.0f;
    switch (index) {
        case 0:
            value = 80.0f;
            break;
        case 1:
            value = 20.0f;
            break;
            
        default:
            break;
    }
    
    return value;
}

@end
