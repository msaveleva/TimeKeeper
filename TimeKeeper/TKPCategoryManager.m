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

@property (strong, nonatomic) NSTimer *stopwatchTimer;
@property (strong, nonatomic) NSDate *stopwatchStartDate;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

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
    if (!self.dateFormatter) {
        self.dateFormatter = [NSDateFormatter new];
        
        [self.dateFormatter setDateFormat:@"hh:mm:ss"];
        [self.dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    }
    
    [self startStopwatch];
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
    
    [self stopStopwatch];
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

#pragma mark - Stopwatch for category

- (void)startStopwatch
{
    self.stopwatchStartDate = [NSDate date];
    self.stopwatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                           target:self
                                                         selector:@selector(updateStopwatchTime:)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (void)stopStopwatch
{
    self.stopwatchStartDate = nil;
    [self.stopwatchTimer invalidate];
    [self.delegate updateStopwatch:@"--:--:--"];
}

- (void)updateStopwatchTime:(id)sender
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.stopwatchStartDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *stopwatchValue = [self.dateFormatter stringFromDate:timerDate];
    
    if (self.timeView) {
        self.timeView.categoryStopwatchLabel.text = stopwatchValue;
    }
    
    [self.delegate updateStopwatch:stopwatchValue];
}

@end
