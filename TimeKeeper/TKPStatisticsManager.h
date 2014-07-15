//
//  TKPStatisticsManager.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 15/07/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKPStatisticsManager : NSObject

/**
 Return arrays of TKPCategory objects
 */
- (NSArray *)loadProductiveCategories;
- (NSArray *)loadNeutralCategories;
- (NSArray *)loadUnproductiveCategories;

/**
 Return time spent for all category type
 */
- (double)loadProductiveTime;
- (double)loadNeutralTime;
- (double)loadUnproductiveTime;

/**
 Return time in percents
 */
- (NSInteger)loadProductivePercents;
- (NSInteger)loadNeutralPercents;
- (NSInteger)loadUnproductivePercents;

@end
