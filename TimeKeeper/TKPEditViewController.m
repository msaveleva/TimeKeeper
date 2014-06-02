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
#import "UIColor+CustomColors.h"
#import "FXBlurView.h"
#import "TKPTimeTypeView.h"

static NSString * const kEditNameCell = @"editNameCell";
static NSString * const kCategoryTypeCell = @"categoryTypeCell";

static CGFloat const kEditNameCellHeight = 68.0f;
static CGFloat const kCategoryTypeCellHeight = 63.0f;
static CGFloat const kBlurRadius = 20.0f;

@interface TKPEditViewController ()

@property (weak, nonatomic) IBOutlet TKPHeaderView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *editTableView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) FXBlurView *blurView;
@property (nonatomic) BOOL isSelectingTimeType;
@property (weak, nonatomic) IBOutlet TKPTimeTypeView *timeTypeView;

- (void)switchBlur;

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
    
    self.isSelectingTimeType = NO;
    
    //set header view mode
    [self.headerView enableEditionMode];
    
    //set colors
    self.view.backgroundColor = [UIColor categoryCellBackgroundColor];
    self.editTableView.backgroundColor = [UIColor categoryCellBackgroundColor];
    
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
    
    //make blur view
    self.blurView = [[FXBlurView alloc] initWithFrame:self.view.frame];
    self.blurView.backgroundColor = [UIColor clearColor];
    self.blurView.tintColor = [UIColor clearColor];
    self.blurView.blurRadius = kBlurRadius;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteCategory:(id)sender {
}

- (void)switchBlur
{
    if (self.isSelectingTimeType) {
        [self.view addSubview:self.blurView];
    } else {
        [self.blurView removeFromSuperview];
    }
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
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
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
