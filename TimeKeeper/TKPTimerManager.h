//
//  TKPTimerManager.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 08/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKPTimerManager : NSObject

+ (instancetype)sharedManager;

- (void)startTimerWithTime:(NSInteger)time;

@end
