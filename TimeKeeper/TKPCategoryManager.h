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

typedef NS_ENUM(NSInteger, TKPCategoryStatus) {
    TKPCategoryStatusStopped,
    TKPCategoryStatusRecording,
    TKPCategoryStatusPaused,
};

@protocol TKPStopWatchUpdateDelegate <NSObject>

- (void)updateStopwatch:(NSString *)stopwatchValue;
- (void)stopCategoryTraking;

@end

@interface TKPCategoryManager : NSObject

@property (weak, nonatomic) id<TKPStopWatchUpdateDelegate> delegate;
@property (weak, nonatomic) TKPTimeView *timeView;
@property (strong, nonatomic) NSString *currentCategoryName;
@property (nonatomic) TKPCategoryStatus status;

+ (instancetype)sharedInstance;

- (void)startCategory:(TKPCategory *)category;
/**
 This method will also called when pause category
 */
- (void)stopCategory;

/**
 Get all categories
 */
- (NSArray *)loadCategories;

@end
