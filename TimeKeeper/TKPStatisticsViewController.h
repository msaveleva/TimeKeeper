//
//  TKPStatisticsViewController.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 13/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

@interface TKPStatisticsViewController : UIViewController
<
UITableViewDataSource,
UITableViewDelegate,
XYPieChartDataSource,
XYPieChartDelegate
>

@end
