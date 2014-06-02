//
//  TKPTimeTypeView.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 02/06/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKPTimeTypeView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *productiveTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *neutralTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *unproductiveTimeButton;

@end
