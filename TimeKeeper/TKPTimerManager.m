//
//  TKPTimerManager.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 08/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPTimerManager.h"

@interface TKPTimerManager ()

@property (strong, nonatomic) NSTimer *timer;

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
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInSeconds
                                                  target:self
                                                selector:@selector(timeExpiredNotification:)
                                                userInfo:nil
                                                 repeats:NO];
}

- (void)timeExpiredNotification:(id)sender
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    [localNotification setFireDate:nil];
    [localNotification setAlertBody:@"Hey, time has already passed"];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    [self.timer invalidate];
}

@end
