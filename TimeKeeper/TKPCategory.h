//
//  TKPCategory.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 06/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TKPTimeAndDate;

typedef NS_ENUM(NSUInteger, TKPCategoryType) {
    TKPCategoryTypeProductiveTime,
    TKPCategoryTypeNeutralTime,
    TKPCategoryTypeUnproductiveTime
};

@interface TKPCategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSSet *timesAndDates;

- (TKPCategoryType)getCategoryType;
- (void)setCategoryType:(TKPCategoryType)categoryType;

@end

@interface TKPCategory (CoreDataGeneratedAccessors)

- (void)addTimesAndDatesObject:(TKPTimeAndDate *)value;
- (void)removeTimesAndDatesObject:(TKPTimeAndDate *)value;
- (void)addTimesAndDates:(NSSet *)values;
- (void)removeTimesAndDates:(NSSet *)values;

@end
