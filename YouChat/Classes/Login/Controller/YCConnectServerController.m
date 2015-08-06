//
//  YCConnectServerController.m
//  YouChat
//
//  Created by Kowloon on 15/7/17.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCConnectServerController.h"
#import "YCLoginController.h"

@interface YCConnectServerController ()

@property (weak, nonatomic) IBOutlet UITextField *hostPortF;
@property (weak, nonatomic) IBOutlet UITextField *domainF;
@property (weak, nonatomic) IBOutlet UITextField *hostNameF;
@property (weak, nonatomic) IBOutlet UIButton *connectSeverBtn;

@end

@implementation YCConnectServerController

- (void)dealloc
{
    YCLog(@"%@ -> dealloc", NSStringFromClass([self class]));
}

- (IBAction)connectClick:(id)sender {
    [YCUserInfo sharedYCUserInfo].domain = self.domainF.text;
    [YCUserInfo sharedYCUserInfo].hostPort = [self.hostPortF.text intValue];
    [YCUserInfo sharedYCUserInfo].hostName = self.hostNameF.text;
    [YCUserInfo sharedYCUserInfo].connectType = YCConnectTypeOfConnectServer;
    YC_WS(ws);
    [MBProgressHUD showMessage:@"Connect Server..." toView:self.view];
    [super connectCompletion:^(BOOL success) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:ws.view animated:YES];
            if (success) {
                [ws pushToLoginVC];
            }
            else {
                [MBProgressHUD showError:@"Connect Failure" toView:ws.view];
            }
        });
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = YC_TitleOfConnectServer;
    [self.connectSeverBtn setResizeN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];

}
- (void)pushToLoginVC
{
    YCLoginController *login = [[YCLoginController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}
@end
