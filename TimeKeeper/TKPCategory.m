//
//  TKPCategory.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 05/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPCategory.h"


@implementation TKPCategory

@dynamic type;
@dynamic name;

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
