//
//  YCProfilerController.m
//  YouChat
//
//  Created by Kowloon on 15/7/22.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCProfilerController.h"
#import "XMPPvCardTemp.h"
#import "YCBaseGroup.h"
#import "YCBaseItem.h"
#import "YCBaseArrowItem.h"
#import "YCRightImageItem.h"
#import "YCEditInfoController.h"
#import "YCBaseCell.h"
@interface YCProfilerController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, YCEditInfoControllerDelegate>
@property(nonatomic, strong)NSIndexPath *indexPath;
@end

@implementation YCProfilerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setGroupOne];
    [self setGroupTwo];
}

- (void)setGroupOne
{
    YCBaseGroup *groupOne = [[YCBaseGroup alloc] init];

    XMPPvCardTempModule *vCardTM = [YCXMPPTool sharedYCXMPPTool].vCardTempModule;
    XMPPvCardTemp *vCardTemp = vCardTM.myvCardTemp;
    YCBaseItem *one = [YCRightImageItem rightItemWithTitle:YC_TitleOfIcon image:vCardTemp.photo];
    YC_WS(ws);
    one.option = ^{
        [ws alertActionShow];
    };
    YCBaseItem *two = [YCBaseArrowItem arrowItemWithTitle:YC_TitleOfNickname destVcClass:[YCEditInfoController class]];
    two.subtitle = vCardTemp.nickname;
    YCBaseItem *three = [YCBaseItem itemWithTitle:YC_TitleOfAccount];
    three.subtitle = [YCUserInfo sharedYCUserInfo].user;
    groupOne.items = @[one, two, three];
    [self.dataSource addObject:groupOne];
}

- (void)alertActionShow
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *takeAction = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        YCLog(@"takeAction");
        [self takeIconfromPhoto:YES];
    }];
    UIAlertAction *chooseAction = [UIAlertAction actionWithTitle:@"Choose from Photos" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        YCLog(@"chooseAction");
        [self takeIconfromPhoto:NO];
    }];
    [alert addAction:takeAction];
    [alert addAction:chooseAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)takeIconfromPhoto:(BOOL)isfromPhoto
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    // 设置代理
    imagePicker.delegate =self;
    // 设置允许编辑
    imagePicker.allowsEditing = YES;
    if (isfromPhoto) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)setGroupTwo
{
    YCBaseGroup *groupTwo = [[YCBaseGroup alloc] init];
    
    XMPPvCardTempModule *vCardTM = [YCXMPPTool sharedYCXMPPTool].vCardTempModule;
    XMPPvCardTemp *vCardTemp = vCardTM.myvCardTemp;
    
    YCBaseItem *one = [YCBaseArrowItem arrowItemWithTitle:YC_TitleOfCompany destVcClass:[YCEditInfoController class]];
    one.subtitle = vCardTemp.orgName;
    
    YCBaseItem *two = [YCBaseArrowItem arrowItemWithTitle:YC_TitleOfDepartment destVcClass:[YCEditInfoController class]];
    two.subtitle = [vCardTemp.orgUnits firstObject];
    
    YCBaseItem *three = [YCBaseArrowItem arrowItemWithTitle:YC_TitleOfPosition destVcClass:[YCEditInfoController class]];
    three.subtitle = vCardTemp.title;

    YCBaseItem *four = [YCBaseArrowItem arrowItemWithTitle:YC_TitleOfTelephone destVcClass:[YCEditInfoController class]];
    four.subtitle = vCardTemp.note;
    
    YCBaseItem *five = [YCBaseArrowItem arrowItemWithTitle:YC_TitleOfEmail destVcClass:[YCEditInfoController class]];
    five.subtitle = vCardTemp.mailer;
    
    groupTwo.items = @[one, two, three, four, five];
    
    [self.dataSource addObject:groupTwo];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    YCBaseGroup *group = self.dataSource[indexPath.section];
    YCBaseItem *item = group.items[indexPath.row];
    [item.title isEqualToString:YC_TitleOfIcon] ? (height = 80) : (height = 44);
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.indexPath = indexPath;
    YCBaseGroup *group = self.dataSource[indexPath.section];
    YCBaseItem *setItem = group.items[indexPath.row];
    if (setItem.option)
    { // block有值(点击这个cell,.有特定的操作需要执行)
        setItem.option();
    }
    else if ([setItem isKindOfClass:[YCBaseArrowItem class]])
    { // 箭头
        YCBaseArrowItem *arrowItem = (YCBaseArrowItem *)setItem;
        if ([NSStringFromClass(arrowItem.destVcClass) isEqualToString:NSStringFromClass([YCEditInfoController class])]) {
            // 如果没有需要跳转的控制器
            if (arrowItem.destVcClass == nil) return;
            YCEditInfoController *editVC = [[arrowItem.destVcClass alloc] init];
            editVC.delegate = self;
            editVC.editTitle = setItem.subtitle;
            [self.navigationController pushViewController:editVC animated:YES];
        }
    }
}

#pragma mark - YCEditInfoControllerDelegate
- (void)editInfoController:(YCEditInfoController *)profilerController DidSaveTitle:(NSString *)title
{
    YCBaseCell *cell = (YCBaseCell *)[self.tableView cellForRowAtIndexPath:self.indexPath];
    cell.item.subtitle = title;
    [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self uploadInformationToServerWiteItem:cell.item];
}
- (void)uploadInformationToServerWiteItem:(YCBaseItem *)item
{
    XMPPvCardTempModule *vCardTM = [YCXMPPTool sharedYCXMPPTool].vCardTempModule;
    XMPPvCardTemp *vCardTemp = vCardTM.myvCardTemp;
    if ([item.title isEqualToString:YC_TitleOfNickname]) {
        vCardTemp.nickname = item.subtitle;// 昵称
    }
    else if ([item.title isEqualToString:YC_TitleOfCompany]) {
        vCardTemp.orgName = item.subtitle;// 公司
    }
    else if ([item.title isEqualToString:YC_TitleOfDepartment]) {
        vCardTemp.orgUnits = @[item.subtitle];// 部门
    }
    else if ([item.title isEqualToString:YC_TitleOfPosition]) {
        vCardTemp.title = item.subtitle;// 职位
    }
    else if ([item.title isEqualToString:YC_TitleOfTelephone]) {
        vCardTemp.note = item.subtitle;// 电话
    }
    else if ([item.title isEqualToString:YC_TitleOfEmail]) {
        vCardTemp.mailer = item.subtitle;// 邮件
    }
    else if ([item.title isEqualToString:YC_TitleOfIcon]) {
        YCRightImageItem *imageItem = (YCRightImageItem *)item;
        vCardTemp.photo = imageItem.rightImage;
    }
    //更新 这个方法内部会实现数据上传到服务，无需程序自己操作
    [[YCXMPPTool sharedYCXMPPTool].vCardTempModule updateMyvCardTemp:vCardTemp];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    YCBaseCell *cell = (YCBaseCell *)[self.tableView cellForRowAtIndexPath:self.indexPath];
    YCRightImageItem *imageItem = (YCRightImageItem *)cell.item;
    imageItem.rightImage = UIImagePNGRepresentation(image);
    [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self uploadInformationToServerWiteItem:imageItem];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end









