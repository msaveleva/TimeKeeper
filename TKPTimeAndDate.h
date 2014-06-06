//
//  TKPTimeAndDate.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 06/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TKPCategory;

@interface TKPTimeAndDate : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) TKPCategory *category;

@end
