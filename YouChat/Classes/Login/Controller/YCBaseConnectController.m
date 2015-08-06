//
//  YCBaseConnectController.m
//  YouChat
//
//  Created by Kowloon on 15/7/17.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCBaseConnectController.h"

@interface YCBaseConnectController ()

@property(nonatomic, copy)YCOptionBool completionBlock;

@end

@implementation YCBaseConnectController

- (void)connect
{
    YC_WS(ws);
    [[YCXMPPTool sharedYCXMPPTool] xmppConnectServerResultBlock:^(XMPPResultType type) {
        [ws handleResultType:type];
    }];
}
- (void)connectCompletion:(YCOptionBool)block
{
    self.completionBlock = block;
    [self connect];
}

-(void)handleResultType:(XMPPResultType)type{
    // 主线程刷新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (type) {
            case XMPPResultTypeLoginSuccess:
                YCLog(@"登录成功");
                [self callCompletionBlock:YES];
                break;
            case XMPPResultTypeLoginFailure:
                YCLog(@"登录失败");
                [self callCompletionBlock:NO];
                break;
            case XMPPResultTypeNetErr:
                [self callCompletionBlock:NO];
                break;
            case XMPPResultTypeConnectServiceSuccess:
                [self callCompletionBlock:YES];
                break;
            case XMPPResultTypeConnectServiceFailure:
                [self callCompletionBlock:NO];
                break;
            case XMPPResultTypeRegisterSuccess:
                [self callCompletionBlock:YES];
                break;
            case XMPPResultTypeRegisterFailure:
                [self callCompletionBlock:NO];
                break;
            default:
                break;
        }
    });
    
}


- (void)callCompletionBlock:(BOOL)success
{
    if (self.completionBlock) {
        self.completionBlock(success);
    }
}

- (void)jumpToMainWindow
{
    [self dismissViewControllerAnimated:NO completion:nil];
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = main.instantiateInitialViewController;
    [YC_UserDefaults setBool:YES forKey:YC_TagOfLoginSuccess];
    [YC_UserDefaults synchronize];
}

@end







