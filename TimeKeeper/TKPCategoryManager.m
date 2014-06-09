//
//  TKPCategoryManager.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 09/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPCategoryManager.h"
#import "TKPCategory.h"
#import "TKPTimeAndDate.h"
#import "TKPAppDelegate.h"

static NSString * const kTimeAndDateManagedObject = @"TKPTimeAndDate";

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
    self.isCategoryActive = YES;
}

- (void)stopCategory:(TKPCategory *)category
{
    TKPAppDelegate *appDelegate = (TKPAppDelegate *)[[UIApplication sharedApplication] delegate];
    TKPTimeAndDate *timeAndDate =
        [NSEntityDescription insertNewObjectForEntityForName:kTimeAndDateManagedObject
                                      inManagedObjectContext:appDelegate.managedObjectContext];
    timeAndDate.startDate = self.startDate;
    timeAndDate.endDate = [NSDate date];
    [category addTimesAndDatesObject:timeAndDate];
    
    NSError *error;
    if (![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Unable to save time for category! %@", error);
    }
    
    self.isCategoryActive = NO;
}

- (NSString *)currentCategoryName
{
    if (self.category) {
        return self.category.name;
    } else {
        return @"No running category"; //TODO: localize
    }
}

- (NSString *)currentCategoryTimer
{
    NSString *categoryTimer;
    return categoryTimer;
}

@end
