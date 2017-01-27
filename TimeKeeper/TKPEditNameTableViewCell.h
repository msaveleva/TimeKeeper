//
//  TKPEditNameTableViewCell.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 28/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKPCategory;

@interface TKPEditNameTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

- (void)configureCellWithDelegate:(id)delegate category:(TKPCategory *)category;

@end
