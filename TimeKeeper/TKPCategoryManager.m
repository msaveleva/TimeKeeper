//
//  TKPCategoryManager.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 09/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPCategoryManager.h"
#import "TKPCategory.h"

@interface TKPCategoryManager ()

@property (nonatomic, strong) TKPCategory *category;
@property (nonatomic, strong) NSDate *startDate;

@end

@implementation TKPCategoryManager

+ (instancetype)sharedInstance
{
    static TKPCategoryManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (void)startCategory:(TKPCategory *)category
{
    self.category = category;
    self.startDate = [NSDate date];
    //TODO: handle category start
}

- (void)stopCategory:(TKPCategory *)category
{
    //TODO: handle category pause and saving with endDate
//    NSDate *endDate = [NSDate date];
}

- (NSString *)currentCategoryName
{
    if (self.category) {
        return self.category.name;
    } else {
        return @"No running category"; //TODO: localize
    }
}

@end
