//
//  TKPStatisticsManager.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 15/07/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPStatisticsManager.h"
#import "TKPCategoryManager.h"
#import "TKPTimeAndDate.h"

@interface TKPStatisticsManager ()

@end

@implementation TKPStatisticsManager

+ (instancetype)sharedInstance
{
    static TKPStatisticsManager *statisticsManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        statisticsManager = [[TKPStatisticsManager alloc] init];
    });
    
    return statisticsManager;
}

- (NSArray *)loadCategoriesForType:(TKPCategoryType)type
{
    //TODO: fix currentCategoryName
    NSMutableArray *categories = [NSMutableArray arrayWithArray:[[TKPCategoryManager sharedInstance] loadCategories]];
    NSString *currentCategoryName = [[TKPCategoryManager sharedInstance] currentCategoryName];
    for (TKPCategory *category in categories) {
        if ([category.name isEqualToString:currentCategoryName]) {
            [categories removeObject:category];
            break;
        }
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = %@", @(type)];
    NSArray *toReturn =  [categories filteredArrayUsingPredicate:predicate];
    
    return toReturn;
}

- (double)loadTimeForType:(TKPCategoryType)type
{
    double timeRange = 0;
    NSArray *categoriesWithType = [self loadCategoriesForType:type];
    for (TKPCategory *category in categoriesWithType) {
        for (TKPTimeAndDate *timeAndDate in category.timesAndDates) {
            NSTimeInterval interval = [timeAndDate.endDate timeIntervalSinceDate:timeAndDate.startDate];
            timeRange += interval;
        }
    }
    
    return timeRange;
}

@end
