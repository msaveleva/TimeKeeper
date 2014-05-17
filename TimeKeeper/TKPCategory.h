//
//  TKPCategory.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TKPCategoryType) {
    TKPCategoryTypeProductiveTime,
    TKPCategoryTypeNeutralTime,
    TKPCategoryTypeUnproductiveTime
};

@interface TKPCategory : NSObject

@property (strong, nonatomic) NSString *categoryName;
@property (nonatomic) TKPCategoryType *categoryType;

@end
