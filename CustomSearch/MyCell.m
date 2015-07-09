//
//  MyCell.m
//  CustomSearch
//
//  Created by apple on 15/7/4.
//  Copyright (c) 2015年 CloudRoom. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell
#pragma mark - public methods
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    return [[self alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"MyCell";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

@end
