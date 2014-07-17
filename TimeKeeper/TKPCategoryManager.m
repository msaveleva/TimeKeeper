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
@property (nonatomic) NSInteger passedTime;

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
    
    [self startStopwatch];
    self.timeView.pauseButton.enabled = YES;
    self.status = TKPCategoryStatusRecording;
    self.currentCategoryName = self.category.name;
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
    self.status = TKPCategoryStatusStopped;
    self.currentCategoryName = nil;
}

- (void)pauseCategory
{
    //TODO: implement
    self.status = TKPCategoryStatusPaused;
}

#pragma mark - Stopwatch for category

- (void)startStopwatch
{
    self.stopwatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                           target:self
                                                         selector:@selector(updateStopwatchTime:)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (void)stopStopwatch
{
    self.passedTime = 0;
    [self.stopwatchTimer invalidate];
    [self.delegate updateStopwatch:@"00:00:00"];
}

- (void)pauseStopwatch
{
    [self.stopwatchTimer invalidate];
}

- (void)updateStopwatchTime:(id)sender
{
    NSString *stopwatchValue = [self makeTimeStringFromInterval:self.passedTime];
    if (self.timeView) {
        self.timeView.categoryStopwatchLabel.text = stopwatchValue;
        if (self.category) {
            self.timeView.categoryNameLabel.text = self.category.name;
        }
    }

    self.passedTime++;
    
    [self.delegate updateStopwatch:stopwatchValue];
}

- (NSString *)makeTimeStringFromInterval:(double)interval
{
    int timeInterval = (int)interval;
    int seconds = timeInterval % 60;
    int minutes = (timeInterval / 60) % 60;
    int hours = timeInterval / 3600;
    
    NSString *result = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    
    return  result;
}

- (NSArray *)loadCategories
{
    NSArray *allCategories;
    NSError *error;
    TKPAppDelegate *appDelegate = (TKPAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TKPCategory" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    allCategories = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return allCategories;
}

@end
