//
//  TKPCategoryManager.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 09/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKPTimeView.h"

@class TKPCategory;

@protocol TKPStopWatchUpdateDelegate <NSObject>

- (void)updateStopwatch:(NSString *)stopwatchValue;
- (void)stopCategoryTraking;

@end

@interface TKPCategoryManager : NSObject

@property (nonatomic) BOOL isCategoryRecording;
@property (weak, nonatomic) id<TKPStopWatchUpdateDelegate> delegate;
@property (weak, nonatomic) TKPTimeView *timeView;

+ (instancetype)sharedInstance;

- (void)startCategory:(TKPCategory *)category;
/**
 This method will also called when pause category
 */
- (void)stopCategory;
- (NSString *)currentCategoryName;

@end
