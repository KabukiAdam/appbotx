//
//  ABXBaseListViewController.m
//  Sample Project
//
//  Created by Stuart Hall on 22/05/2014.
//  Copyright (c) 2014 Appbot. All rights reserved.
//

#import "ABXBaseListViewController.h"

#import "ABXNavigationController.h"

#import "NSString+ABXLocalized.h"

#import "ABXFont.h"


@interface ABXBaseListViewController()

@end

@implementation ABXBaseListViewController

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource= nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)showFromController:(UIViewController*)controller
{
    ABXBaseListViewController *viewController = [[self alloc] init];
    UINavigationController *nav = [[ABXNavigationController alloc] initWithRootViewController:viewController];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Show as a sheet on iPad
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [controller presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UI

- (void)setupUI
{
    // Table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.dataSource = (id<UITableViewDataSource>)self;
    self.tableView.delegate = (id<UITableViewDelegate>)self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 44)];
    self.tableView.tableFooterView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    // Powered by
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    bottom.translatesAutoresizingMaskIntoConstraints = NO;
    bottom.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1];
    [self.view addSubview:bottom];
    [bottom.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [bottom.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [bottom.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    
    UIButton *appbotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    appbotButton.translatesAutoresizingMaskIntoConstraints = NO;
    [appbotButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [appbotButton setTitle:[[@"Powered by" localizedString] stringByAppendingString:@" Appbot"] forState:UIControlStateNormal];
    appbotButton.titleLabel.font = [ABXFont fontWithSize:13];
    [appbotButton addTarget:self action:@selector(onAppbot) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:appbotButton];
    [appbotButton.heightAnchor constraintEqualToConstant:33.0].active = YES;
    [appbotButton.topAnchor constraintEqualToAnchor:bottom.topAnchor].active = YES;
    [appbotButton.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor].active = YES;
    [appbotButton.leadingAnchor constraintEqualToAnchor:bottom.leadingAnchor].active = YES;
    [appbotButton.trailingAnchor constraintEqualToAnchor:bottom.trailingAnchor].active = YES;
    
    // Activity Indicator
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = CGPointMake(CGRectGetMidX(self.view.bounds), 100);
    [self.activityView startAnimating];
    self.activityView.hidesWhenStopped = YES;
    self.activityView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:self.activityView];
    
    // Only show the close button if we are at the root controller
    if (self.navigationController.viewControllers.count == 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                 target:self
                                                 action:@selector(onDone)];
    }
}

#pragma mark - Buttons

- (void)onDone
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)onAppbot
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://appbot.co"]];
}

#pragma mark - Errors

- (void)showError:(NSString*)error
{
    if (!self.errorLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, CGRectGetWidth(self.tableView.bounds) - 20, 100)];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.text = error;
        label.font = [ABXFont fontWithSize:15];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:label];
        self.errorLabel = label;
    }
    else {
        self.errorLabel.text = error;
        self.errorLabel.hidden = NO;
    }
}

@end
