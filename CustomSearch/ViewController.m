//
//  ViewController.m
//  CustomSearch
//
//  Created by apple on 15/7/4.
//  Copyright (c) 2015年 CloudRoom. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "UITabBarController+HideTabBar.h"

@interface ViewController () < UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate >

@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSArray *filterSource;

@end

@implementation ViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUIScreen];
    
    [self setupDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
//    NSLog(@"<============================begin===================================>");
//    NSLog(@"%s:%@",__func__,self.myTableView);
//    NSLog(@"%s:%@",__func__,self.searchDisplayController.searchResultsTableView);
//    NSLog(@"<=============================end====================================>");
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.myTableView] == YES)
        return [self.dataSource count];
    
    return [self.filterSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [MyCell cellWithTableView:tableView];
    
    if ([tableView isEqual:self.myTableView] == YES)
    {
        [cell.textLabel setText:[self.dataSource objectAtIndex:indexPath.row]];
    }
    else
    {
        [cell.textLabel setText:[self.filterSource objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.myTableView] == YES)
        return 44;
    
    return 60;
}

#pragma mark - UISearchDisplayDelegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(@"%s:searchString:%@",__func__,searchString);
    
    // 刷新
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView
{
    if (IOS8_OR_LATER)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    if (IOS8_OR_LATER)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    else if (IOS7_OR_LATER)
    {
        [tableView setContentInset:UIEdgeInsetsZero];
        
        [tableView setScrollIndicatorInsets:UIEdgeInsetsZero];
    }
    
    if (IOS8_OR_LATER || IOS7_OR_LATER)
        [self.tabBarController hideTabBarAnimated:NO];
    
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
    if (IOS8_OR_LATER || IOS7_OR_LATER)
        [self.tabBarController showTabBarAnimated:NO];
}

#pragma mark - event response
- (void)keyboardWillHide
{
    UITableView *tableView = [[self searchDisplayController] searchResultsTableView];
    
    [tableView setContentInset:UIEdgeInsetsZero];
    
    [tableView setScrollIndicatorInsets:UIEdgeInsetsZero];
    
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    CGFloat height = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    UITableView *tableView = [[self searchDisplayController] searchResultsTableView];
    UIEdgeInsets inset;
    
    inset = UIEdgeInsetsMake(0, 0, height + 100, 0);
    
    [tableView setContentInset:inset];
    
    [tableView setScrollIndicatorInsets:inset];
}

#pragma mark - private methods
- (void)setupUIScreen
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)] == YES)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.myTableView.tableFooterView = [[UIView alloc] init];
    
    [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
    
    self.searchDisplayController.searchResultsTableView.tableFooterView = [[UIView alloc] init];
    
    self.searchDisplayController.displaysSearchBarInNavigationBar = NO;
}

- (void)setupDataSource
{
    self.dataSource = @[@"第01行",
                        @"第02行",
                        @"第03行",
                        @"第04行",
                        @"第05行",
                        @"第06行",
                        @"第07行",
                        @"第08行",
                        @"第09行",
                        @"第10行",
                        @"第11行",
                        @"第12行",
                        @"第13行",
                        @"第14行",
                        @"第15行"];
    
    self.filterSource = @[@"第01行",
                          @"第02行",
                          @"第03行",
                          @"第04行",
                          @"第05行",
                          @"第06行",
                          @"第07行",
                          @"第08行",
                          @"第09行",
                          @"第10行"];
}

@end
