//
//  TKPTimeScrollView.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 21/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKPTimeScrollView : UIView

@property (strong, nonatomic) IBOutlet UIScrollView *timeIntervalScrollView;
@property (strong, nonatomic) IBOutlet UIView *timeIntervalView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end
