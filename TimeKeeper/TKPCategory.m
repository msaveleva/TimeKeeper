//
//  TKPCategory.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 06/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPCategory.h"
#import "TKPTimeAndDate.h"


@implementation TKPCategory

@dynamic name;
@dynamic type;
@dynamic timesAndDates;

- (TKPCategoryType)getCategoryType
{
    TKPCategoryType categoryType = [self.type integerValue];
    return categoryType;
}

- (void)setCategoryType:(TKPCategoryType)categoryType
{
    self.type = [NSNumber numberWithInteger:categoryType];
}

@end
