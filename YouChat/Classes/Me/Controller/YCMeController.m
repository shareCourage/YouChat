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
@interface YCMeController ()

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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.dataSource removeAllObjects];
//    [self setGroupOne:[YCXMPPTool sharedYCXMPPTool].vCardTempModule.myvCardTemp];
//    [self.tableView reloadData];
}
- (void)setGroupOne:(XMPPvCardTemp *)vCardTemp
{
    NSData *photo = vCardTemp.photo;
    YCBaseItem *one = [YCBaseArrowItem arrowItemWithDataIcon:photo title:vCardTemp.nickname destVcClass:[YCProfilerController class]];
    one.subtitle = [YCUserInfo sharedYCUserInfo].user;
    YCBaseGroup *group = [[YCBaseGroup alloc] init];
    group.items = @[one];
    [self.dataSource addObject:group];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80.f;
    }
    return 44;
}

@end







