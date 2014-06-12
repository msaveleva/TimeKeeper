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
@property (strong, nonatomic) NSDate *zeroDate;

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
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"HH:mm:ss"];
    }
    
    if (!self.zeroDate) {
        NSDateComponents *components = [NSDateComponents new];
        [components setHour:0];
        [components setMinute:0];
        [components setSecond:0];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        self.zeroDate = [calendar dateFromComponents:components];
    }
    
    [self startStopwatch];
    self.timeView.pauseButton.enabled = YES;
    self.isCategoryActive = YES;
}

- (void)stopCategory
{
    TKPAppDelegate *appDelegate = (TKPAppDelegate *)[[UIApplication sharedApplication] delegate];
    TKPTimeAndDate *timeAndDate =
        [NSEntityDescription insertNewObjectForEntityForName:kTimeAndDateManagedObject
                                      inManagedObjectContext:appDelegate.managedObjectContext];
    timeAndDate.startDate = self.startDate;
    timeAndDate.endDate = [NSDate date];
    [self.category addTimesAndDatesObject:timeAndDate];
    
    NSError *error;
    if (![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Unable to save time for category! %@", error);
    }
    
    [self.timeView clearTimeView];
    [self.delegate stopCategoryTraking];
    [self stopStopwatch];
    self.isCategoryActive = NO;
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
    [self.delegate updateStopwatch:@"00:00:00"];
}

- (void)updateStopwatchTime:(id)sender
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.stopwatchStartDate];
    NSDate *timerDate = [NSDate dateWithTimeInterval:timeInterval sinceDate:self.zeroDate];
    NSString *stopwatchValue = [self.dateFormatter stringFromDate:timerDate];
    
    if (self.timeView) {
        self.timeView.categoryStopwatchLabel.text = stopwatchValue;
        if (self.category) {
            self.timeView.categoryNameLabel.text = self.category.name;
        }
    }
    
    [self.delegate updateStopwatch:stopwatchValue];
}

@end
