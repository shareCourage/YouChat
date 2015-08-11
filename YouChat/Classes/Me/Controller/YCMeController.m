//
//  YCMeController.m
//  YouChat
//
//  Created by Kowloon on 15/7/16.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCMeController.h"
#import "XMPPvCardTemp.h"
#import "YCBaseGroup.h"
#import "YCBaseItem.h"
#import "YCBaseArrowItem.h"
#import "YCProfilerController.h"
#import "YCBaseCell.h"
@interface YCMeController ()<YCProfilerControllerDelegate>

@end

@implementation YCMeController
- (void)dealloc
{
    YCLog(@"%@ -> dealloc", NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = YC_TitleOfMe;
    [self setGroupOne:[YCXMPPTool sharedYCXMPPTool].vCardTempModule.myvCardTemp];
    [self setGroupTwo];
}

- (void)setGroupOne:(XMPPvCardTemp *)vCardTemp
{
    NSData *photo = vCardTemp.photo;
    YCBaseItem *one = [YCBaseArrowItem arrowItemWithDataIcon:photo title:vCardTemp.nickname destVcClass:[YCProfilerController class]];
    one.subtitle = [YCUserInfo sharedYCUserInfo].user;
    YCBaseGroup *group = [[YCBaseGroup alloc] init];
    group.items = @[one];
    [self.dataSource insertObject:group atIndex:0];
}
- (void)setGroupTwo
{
    YCBaseItem *item =[YCBaseArrowItem itemWithTitle:@"注销当前用户"];
    item.option = ^{
        [YCUserInfo sharedYCUserInfo].connectType = YCConnectTypeOfLogout;
        [[YCXMPPTool sharedYCXMPPTool] xmppUserlogoutResultBlock:nil];
    };
    YCBaseGroup *group = [[YCBaseGroup alloc] init];
    group.items = @[item];
    [self.dataSource addObject:group];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YCBaseCell *cell = [YCBaseCell cellWithTableView:tableView style:UITableViewCellStyleSubtitle];
    YCBaseGroup *group = self.dataSource[indexPath.section];
    cell.item = group.items[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 100.f;
    }
    return 44;
}


- (void)pushVCWithClass:(Class)destClass settingItem:(YCBaseItem *)item
{
    // 如果没有需要跳转的控制器
    if (destClass == nil) return;
    UIViewController *vc = [[destClass alloc] init];
    vc.title = item.title;
    YCProfilerController *profiler = nil;
    if ([vc isKindOfClass:[YCProfilerController class]]) {
        profiler = (YCProfilerController *)vc;
        profiler.delegate = self;
    }
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - YCProfilerControllerDelegate
- (void)profilerControllerDidChanged:(YCProfilerController *)profiler
{
    [self.dataSource removeObjectAtIndex:0];
    [self setGroupOne:[YCXMPPTool sharedYCXMPPTool].vCardTempModule.myvCardTemp];
    [self.tableView reloadData];
}

@end







