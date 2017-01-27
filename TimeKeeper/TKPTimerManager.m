//
//  TKPTimerManager.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 08/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPTimerManager.h"

@interface TKPTimerManager ()

@end

@implementation TKPTimerManager

+ (instancetype)sharedManager
{
    static TKPTimerManager *timeManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timeManager = [[self alloc] init];
    });
    
    return timeManager;
}

- (void)startTimerWithTime:(NSInteger)time
{
    NSUInteger timeInSeconds = time * 60;
    NSDate *fireDate = [[NSDate date] dateByAddingTimeInterval:timeInSeconds];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    [localNotification setFireDate:fireDate];
    [localNotification setAlertBody:NSLocalizedString(@"timer.message", nil)];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
