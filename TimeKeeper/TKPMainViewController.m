//
//  TKPViewController.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPMainViewController.h"
#import "TKPCategoryTableViewCell.h"
#import "TKPHeaderView.h"
#import "TKPTimeView.h"

static NSString *const kCellIdentifier = @"categoryCellIdentifier";

@interface TKPMainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;
@property (weak, nonatomic) IBOutlet TKPHeaderView *headerView;
@property (weak, nonatomic) IBOutlet TKPTimeView *timeView;

@end

@implementation TKPMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //remove header and footer
    self.categoriesTableView.tableHeaderView =
        [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.categoriesTableView.bounds.size.width, 1.0f)];
    self.categoriesTableView.tableFooterView =
        [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.categoriesTableView.bounds.size.width, 1.0f)];
}

#pragma mark - Table View methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKPCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                                     forIndexPath:indexPath];
    cell.categoryNameLabel.text = @"Some category name";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //handle selection
}

@end
