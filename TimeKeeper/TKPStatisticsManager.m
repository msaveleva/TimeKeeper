//
//  TKPStatisticsManager.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 15/07/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPStatisticsManager.h"
#import "TKPCategoryManager.h"

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
    NSArray *categories = [[TKPCategoryManager sharedInstance] loadCategories];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = %@", @(type)];
    NSArray *toReturn =  [categories filteredArrayUsingPredicate:predicate];
    
    return toReturn;
}

@end
