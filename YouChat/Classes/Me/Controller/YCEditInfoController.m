//
//  YCEditInfoController.m
//  YouChat
//
//  Created by Kowloon on 15/7/27.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCEditInfoController.h"
#import "YCEditCell.h"
@interface YCEditInfoController ()

@end

@implementation YCEditInfoController

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
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveClick)];
    self.navigationItem.rightBarButtonItem = right;
}
- (void)saveClick
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    YCEditCell *cell = (YCEditCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(editInfoController:DidSaveTitle:)]) {
        [self.delegate editInfoController:self DidSaveTitle:cell.editTitle];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    YCEditCell *cell = [YCEditCell cellWithTableView:tableView];
    cell.editTitle = self.editTitle;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end





