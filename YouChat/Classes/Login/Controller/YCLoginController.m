//
//  YCLoginController.m
//  YouChat
//
//  Created by Kowloon on 15/7/17.
//  Copyright (c) 2015年 Goome. All rights reserved.
//
#import "YCLoginController.h"
#import "YCRegisterController.h"
#import "YCNavigationController.h"
@interface YCLoginController ()<YCRegisterControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation YCLoginController
- (void)dealloc
{
    YCLog(@"%@ -> dealloc", NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = YC_TitleOfLogin;
    // 设置TextField和Btn的样式
    self.pwdField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    [self.pwdField addLeftViewWithImage:@"Card_Lock"];
    [self.loginBtn setResizeN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];
    if ([YCUserInfo sharedYCUserInfo].user) {
        self.userLabel.text = [YCUserInfo sharedYCUserInfo].user;
    }
}
- (IBAction)loginBtnClick:(id)sender {
    
    // 保存数据到单例
    
    YCUserInfo *userInfo = [YCUserInfo sharedYCUserInfo];
    userInfo.user = self.userLabel.text;
    userInfo.pwd = self.pwdField.text;
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
- (IBAction)otherWayLogin:(id)sender {
    YCRegisterController *registerVC = [[YCRegisterController alloc] init];
    registerVC.login = YES;
    registerVC.delegate = self;
    registerVC.title = YC_TitleOfOtherWayOfLogin;
    YCNavigationController *navi = [[YCNavigationController alloc] initWithRootViewController:registerVC];
    [self presentViewController:navi animated:YES completion:nil];
}

- (IBAction)registerBtnClick:(id)sender {
    YCRegisterController *registerVC = [[YCRegisterController alloc] init];
    registerVC.delegate = self;
    registerVC.title = YC_TitleOfRegister;
    YCNavigationController *navi = [[YCNavigationController alloc] initWithRootViewController:registerVC];
    [self presentViewController:navi animated:YES completion:nil];
}

#pragma mark - YCRegisterControllerDelegate
- (void)regisgerViewControllerDidFinishRegister
{
    YCUserInfo *userInfo = [YCUserInfo sharedYCUserInfo];
    self.userLabel.text = userInfo.registerUser;
}

@end








