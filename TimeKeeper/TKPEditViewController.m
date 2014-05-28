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
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[TKPEditNameTableViewCell class]]) {
        return kEditNameCellHeight;
    } else {
        return kCategoryTypeCellHeight;
    }
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //handle selection
}

@end
