//
//  TKPEditViewController.h
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKPCategory;

@interface TKPEditViewController : UIViewController
<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate
>

/**
 если категория != nil, экран открывается в режиме редактирования
 с кнопкой для удаления категории)
 */
@property (strong, nonatomic) TKPCategory *editedCategory;

@end
