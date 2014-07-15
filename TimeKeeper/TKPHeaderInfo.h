//
//  TKPHeaderInfo.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 15/07/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKPCategory.h"

@interface TKPHeaderInfo : NSObject

@property (nonatomic) TKPCategoryType type;
@property (strong, nonatomic) NSString *spentTime;
@property (strong, nonatomic) NSString *persents;

@end

