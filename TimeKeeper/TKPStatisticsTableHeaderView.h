//
//  TKPStatisticsTableViewCell.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 10/07/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TKPUnscrollEventsProtocol <NSObject>

- (void)listWasUnscrolled:(BOOL)isUnscrolled forSection:(NSInteger)section;

@end

@interface TKPStatisticsTableHeaderView : UIView

@property (weak, nonatomic) id<TKPUnscrollEventsProtocol> delegate;

@end
