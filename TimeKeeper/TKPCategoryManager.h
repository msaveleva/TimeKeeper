//
//  TKPCategoryManager.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 09/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKPCategory;

@interface TKPCategoryManager : NSObject

@property (nonatomic) BOOL isCategoryActive;

+ (instancetype)sharedInstance;

- (void)startCategory:(TKPCategory *)category;
/**
 This method will also called when pause category
 */
- (void)stopCategory:(TKPCategory *)category;

- (NSString *)currentCategoryName;
- (NSString *)currentCategoryTimer;

@end
