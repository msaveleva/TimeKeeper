//
//  TKPViewController.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKPCategoryTableViewCell.h"
#import "TKPCategoryManager.h"

@interface TKPMainViewController : UIViewController
<
TKPEditDeleteProtocol,
TKPStopWatchUpdateDelegate
>

@end
