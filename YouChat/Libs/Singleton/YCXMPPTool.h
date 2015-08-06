//
//  YCXMPPTool.h
//  YouChat
//
//  Created by Kowloon on 15/7/17.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#import "Singleton.h"

typedef enum {
    XMPPResultTypeConnectServiceSuccess = 1000,//成功连接服务器
    XMPPResultTypeConnectServiceFailure,//连接服务器失败
    XMPPResultTypeLoginSuccess,//登录成功
    XMPPResultTypeLoginFailure,//登录失败
    XMPPResultTypeNetErr,//网络不给力
    XMPPResultTypeRegisterSuccess,//注册成功
    XMPPResultTypeRegisterFailure,//注册失败
    XMPPResultTypeLogoutSuccess//注销账户成功
}XMPPResultType;



typedef void (^XMPPResultBlock)(XMPPResultType type);// XMPP请求结果的block


@interface YCXMPPTool : NSObject


singleton_interface(YCXMPPTool)

@property(nonatomic, strong)XMPPStream *xmppStream;
@property(nonatomic, strong)XMPPvCardTempModule *vCardTempModule;//电子名片
//@property(nonatomic, strong)XMPPvCardCoreDataStorage *vCardStorage;//电子名片的数据存储

@property (nonatomic, strong)XMPPRosterCoreDataStorage *rosterStorage;//花名册数据存储
@property (nonatomic, strong)XMPPRoster *roster;//花名册模块

- (void)xmppConnectServerResultBlock:(XMPPResultBlock)resultBlock;

/**
 *  用户注销
 */
-(void)xmppUserlogoutResultBlock:(XMPPResultBlock)resultBlock;





@end









