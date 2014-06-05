//
//  TKPCategory.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 05/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef NS_ENUM(NSUInteger, TKPCategoryType) {
    TKPCategoryTypeProductiveTime,
    TKPCategoryTypeNeutralTime,
    TKPCategoryTypeUnproductiveTime
};

@interface TKPCategory : NSManagedObject

@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * name;

@end
