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

- (NSArray *)loadCategoriesWithourCurrent
{
    NSMutableArray *categories = [NSMutableArray arrayWithArray:[[TKPCategoryManager sharedInstance] loadCategories]];
    NSString *currentCategoryName = [[TKPCategoryManager sharedInstance] currentCategoryName];
    for (TKPCategory *category in categories) {
        if ([category.name isEqualToString:currentCategoryName]) {
            [categories removeObject:category];
            break;
        }
    }
    
    return (NSArray *)categories;
}

- (NSArray *)loadCategoriesForType:(TKPCategoryType)type
{
    NSArray *categories = [self loadCategoriesWithourCurrent];
    
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

- (double)loadTimeForCategoryNamed:(NSString *)categoryName
{
    double result = 0;
    NSArray *categories = [self loadCategoriesWithourCurrent];
    for (TKPCategory *category in categories) {
        if ([category.name isEqualToString:categoryName]) {
            for (TKPTimeAndDate *timeAndDate in category.timesAndDates) {
                NSTimeInterval interval = [timeAndDate.endDate timeIntervalSinceDate:timeAndDate.startDate];
                result += interval;
            }
        }
    }
    
    return result;
}

- (NSInteger)loadPercentsForType:(TKPCategoryType)type
{
    double result = 0;
    double productiveTime = [self loadTimeForType:TKPCategoryTypeProductiveTime];
    double neutralTime = [self loadTimeForType:TKPCategoryTypeNeutralTime];
    double unproductiveTime = [self loadTimeForType:TKPCategoryTypeUnproductiveTime];
    
    double sum = productiveTime + neutralTime + unproductiveTime;
    double onePercent = sum / 100;
    
    int productivePercents = 0;
    int neutralPercents = 0;
    int unproductivePercents = 0;
    
    if (productiveTime > 0) {
        productivePercents = productiveTime/onePercent;
    }
    if (neutralTime > 0) {
        neutralPercents = neutralTime/onePercent;
    }
    if (unproductiveTime > 0) {
        unproductivePercents = unproductiveTime/onePercent;
    }
    
    if (productiveTime > 0 || neutralTime > 0 || unproductiveTime > 0) {
        int delta = 100 - productivePercents - neutralPercents - unproductivePercents;
        productivePercents += delta;
    }

    switch (type) {
        case TKPCategoryTypeProductiveTime:
            result = productivePercents;
            break;
        case TKPCategoryTypeNeutralTime:
            result = neutralPercents;
            break;
        case TKPCategoryTypeUnproductiveTime:
            result = unproductivePercents;
            break;
    }
    
    return result;
}

@end
