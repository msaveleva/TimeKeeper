//
//  TKPViewController.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPMainViewController.h"
#import "TKPHeaderView.h"
#import "TKPCategory.h"
#import "TKPAppDelegate.h"
#import "TKPEditViewController.h"

//static NSString *const kCellIdentifier = @"categoryCellIdentifier";
static NSString *const kCellIdentifier = @"categoryCell";
static NSString *const kEditViewControllerID = @"editViewController";

@interface TKPMainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;
@property (weak, nonatomic) IBOutlet TKPHeaderView *headerView;
@property (strong, nonatomic) NSArray *categoryList;

@end

@implementation TKPMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set header view mode
    [self.headerView enableStandartMode];
    
    //remove header and footer
    self.categoriesTableView.tableHeaderView =
        [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.categoriesTableView.bounds.size.width, 1.0f)];
    self.categoriesTableView.tableFooterView =
        [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.categoriesTableView.bounds.size.width, 1.0f)];
    
    //register custom cell
    UINib *nib = [UINib nibWithNibName:@"TKPCategoryTableViewCell" bundle:nil];
    [self.categoriesTableView registerNib:nib forCellReuseIdentifier:kCellIdentifier];
    
    //setting up buttons
    [self.headerView.addCategoryButton addTarget:self
                                          action:@selector(addCategory:)
                                forControlEvents:UIControlEventTouchUpInside];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadData];
    [self.categoriesTableView reloadData];
}

- (void)addCategory:(UIButton *)button
{
    TKPEditViewController *editViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:kEditViewControllerID];
    [self presentViewController:editViewController animated:YES completion:nil];
}

#pragma mark - Core Data methods

- (void)loadData
{
    NSError *error;
    TKPAppDelegate *appDelegate = (TKPAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TKPCategory" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    self.categoryList = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

#pragma mark - Table View methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categoryList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKPCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                                     forIndexPath:indexPath];
//    cell.categoryNameLabel.text = @"Some category name";
    TKPCategory *category = [self.categoryList objectAtIndex:indexPath.row];
//    cell.categoryNameLabel.text = category.name;
//    [cell setCategoryTimeTypeWithType:category.type.integerValue];
    [cell configureCellWithCategory:category];
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //handle selection
}

#pragma mark - TKPEditDeleteProtocol methods

- (void)editCategory:(TKPCategory *)category
{
    NSLog(@"Category edited!");
}

- (void)deleteCategory:(TKPCategory *)category
{
    TKPAppDelegate *appDelegate = (TKPAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.managedObjectContext deleteObject:category];
    
    NSError *error;
    if (![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Can't delete category: %@", error);
    }
    NSLog(@"Category deleted!");
}

@end
