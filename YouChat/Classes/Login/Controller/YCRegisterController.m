//
//  YCRegisterController.m
//  YouChat
//
//  Created by Kowloon on 15/7/17.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCRegisterController.h"

@interface YCRegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameF;
@property (weak, nonatomic) IBOutlet UITextField *passwordF;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation YCRegisterController

- (void)dealloc
{
    YCLog(@"%@ -> dealloc", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameF.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    self.passwordF.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    [self.registerBtn setResizeN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];
    NSString *registerBtnTitle = nil;
    self.isLogin ? (registerBtnTitle = YC_TitleOfOtherWayOfLogin) : (registerBtnTitle = YC_TitleOfRegister);
    [self.registerBtn setTitle:registerBtnTitle forState:UIControlStateNormal];

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
- (void)cancelClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerClick:(id)sender {
    if (self.userNameF.text.length == 0 || self.passwordF.text.length == 0) return;
    if (self.isLogin) {
        [self isLoginClick];
    }
    else {
        [self isRegisterClick];
    }
}
- (void)isLoginClick
{
    YCUserInfo *userInfo = [YCUserInfo sharedYCUserInfo];
    userInfo.user = self.userNameF.text;
    userInfo.pwd = self.passwordF.text;
    userInfo.connectType = YCConnectTypeOfLogin;
    YC_WS(ws);
    [MBProgressHUD showMessage:@"Login..." toView:self.view];
    [super connectCompletion:^(BOOL success) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:ws.view animated:YES];
            if (success) {
                [super jumpToMainWindow];
            }
            else {
                [MBProgressHUD showError:@"Login Failure" toView:ws.view];
            }
        });
    }];

}
- (void)isRegisterClick
{
    [YCUserInfo sharedYCUserInfo].registerUser = self.userNameF.text;
    [YCUserInfo sharedYCUserInfo].registerPwd = self.passwordF.text;
    [YCUserInfo sharedYCUserInfo].connectType = YCConnectTypeOfRegister;
    YC_WS(ws);
    [MBProgressHUD showMessage:@"Register..." toView:self.view];
    [super connectCompletion:^(BOOL success) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:ws.view animated:YES];
            if (success) {
                [ws cancelClick];
                [ws.delegate regisgerViewControllerDidFinishRegister];
            }
            else {
                [MBProgressHUD showError:@"Register Failure" toView:ws.view];
            }
            
        });
    }];
}
@end











