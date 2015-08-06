//
//  YCBaseController.m
//  YouChat
//
//  Created by Kowloon on 15/7/22.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCBaseController.h"
#import "YCBaseItem.h"
#import "YCBaseArrowItem.h"
#import "YCBaseSwitchItem.h"
#import "YCBaseGroup.h"
#import "YCBaseCell.h"
@interface YCBaseController ()

@end

@implementation YCBaseController
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YCBaseGroup *group = self.dataSource[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YCBaseCell *cell = [YCBaseCell cellWithTableView:tableView];
    YCBaseGroup *group = self.dataSource[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取消选中这行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 2.模型数据
    YCBaseGroup *group = self.dataSource[indexPath.section];
    YCBaseItem *setItem = group.items[indexPath.row];
    
    if (setItem.option)
    { // block有值(点击这个cell,.有特定的操作需要执行)
        setItem.option();
    }
    else if ([setItem isKindOfClass:[YCBaseArrowItem class]])
    { // 箭头
        YCBaseArrowItem *arrowItem = (YCBaseArrowItem *)setItem;
        [self pushVCWithClass:arrowItem.destVcClass settingItem:arrowItem];
    }
    else if ([setItem isKindOfClass:[YCBaseSwitchItem class]])
    {
        
    }
}
- (void)pushVCWithClass:(Class)destClass settingItem:(YCBaseItem *)item
{
    // 如果没有需要跳转的控制器
    if (destClass == nil) return;
    UIViewController *vc = [[destClass alloc] init];
    vc.title = item.title;
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    YCBaseGroup *group = self.dataSource[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    YCBaseGroup *group = self.dataSource[section];
    return group.footer;
}

@end
