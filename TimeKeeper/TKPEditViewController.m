//
//  TKPEditViewController.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 17/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPEditViewController.h"
#import "TKPHeaderView.h"
#import "TKPEditNameTableViewCell.h"
#import "TKPCategoryTypeTableViewCell.h"

static NSString * const kEditNameCell = @"editNameCell";
static NSString * const kCategoryTypeCell = @"categoryTypeCell";

static CGFloat const kEditNameCellHeight = 68.0f;
static CGFloat const kCategoryTypeCellHeight = 63.0f;

@interface TKPEditViewController ()

@property (weak, nonatomic) IBOutlet TKPHeaderView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *editTableView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation TKPEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //remove header and footer
    self.editTableView.tableHeaderView =
        [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.editTableView.bounds.size.width, 1.0f)];
    self.editTableView.tableFooterView =
        [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.editTableView.bounds.size.width, 1.0f)];
    
    //get cells
    UINib *editNameNib = [UINib nibWithNibName:@"TKPEditNameTableViewCell" bundle:nil];
    [self.editTableView registerNib:editNameNib forCellReuseIdentifier:kEditNameCell];
    UINib *categoryTypeNib = [UINib nibWithNibName:@"TKPCategoryTypeTableViewCell" bundle:nil];
    [self.editTableView registerNib:categoryTypeNib forCellReuseIdentifier:kCategoryTypeCell];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteCategory:(id)sender {
}

#pragma mark - Table View methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44.0f;
    switch (indexPath.row) {
        case 0:
            height = kEditNameCellHeight;
            break;
        case 1:
            height = kCategoryTypeCellHeight;
            
        default:
            break;
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    switch (indexPath.row) {
        case 0:
            identifier = kEditNameCell;
            break;
        case 1:
            identifier = kCategoryTypeCell;
            
        default:
            break;
    }
                                              
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                                     forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        TKPEditNameTableViewCell *editCell = (TKPEditNameTableViewCell *)cell;
        editCell.nameTextField.delegate = self;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //handle selection
}

#pragma mark - Text Field methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
