//
//  TKPStatisticsTableViewCell.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 15/07/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKPStatisticsTableViewCell : UITableViewCell

- (void)configureWithCategoryName:(NSString *)name andTime:(NSString *)time;

@end
