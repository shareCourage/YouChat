//
//  YCAddFriendController.m
//  YouChat
//
//  Created by Kowloon on 15/8/10.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCAddFriendController.h"
#import "YCEditCell.h"

@interface YCAddFriendController ()
@property (nonatomic, copy)NSString *friend;

@end

@implementation YCAddFriendController
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
    [self addRightItem];
}
- (void)addRightItem
{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveClick)];
    self.navigationItem.rightBarButtonItem = right;
}
- (void)saveClick
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    YCEditCell *cell = (YCEditCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if (![cell.editTitle isTelphoneNum]) {
        [self showAlert:@"请输入正确的手机号码"];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(addFriendController:didAddUser:)]) {
        [self.delegate addFriendController:self didAddUser:cell.editTitle];
    }
}
-(void)showAlert:(NSString *)msg{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"谢谢" otherButtonTitles:nil, nil];
    [alert show];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YCEditCell *cell = [YCEditCell cellWithTableView:tableView placeholder:@"请输入用户名"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
