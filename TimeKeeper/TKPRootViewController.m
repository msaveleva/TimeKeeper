//
//  TKPRootViewController.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 28/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "TKPRootViewController.h"
#import "TKPTimeView.h"
#import "TKPMainViewController.h"

static NSString * const kMainViewControllerIdentifier = @"mainViewController";

@interface TKPRootViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerViewForChild;
@property (weak, nonatomic) IBOutlet TKPTimeView *timeView;

@end

@implementation TKPRootViewController

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
    
    //adding child view controller
    TKPMainViewController *childViewController = [self.storyboard instantiateViewControllerWithIdentifier:kMainViewControllerIdentifier];
    [self addChildViewController:childViewController];
    [self.containerViewForChild addSubview:childViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
