//
//  TKPStatisticsManager.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 15/07/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKPCategory.h"

@interface TKPStatisticsManager : NSObject

+ (instancetype)sharedInstance;

/**
 Returns arrays of TKPCategory objects
 */
- (NSArray *)loadCategoriesForType:(TKPCategoryType)type;

/**
 Return time spent for all category type
 */
- (double)loadTimeForType:(TKPCategoryType)type;

/**
 Return time in percents
 */
- (NSInteger)loadPercentsForType:(TKPCategoryType)type;

@end
