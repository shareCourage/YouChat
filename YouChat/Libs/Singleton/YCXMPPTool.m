//
//  YCXMPPTool.m
//  YouChat
//
//  Created by Kowloon on 15/7/17.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCXMPPTool.h"
#import "YCUserInfo.h"
#import "YCConnectServerController.h"
#import "YCNavigationController.h"

@interface YCXMPPTool ()<XMPPStreamDelegate>
{
    XMPPReconnect *_reconnect;// 自动连接模块
    
    XMPPvCardCoreDataStorage *_vCardStorage;//电子名片的数据存储
    
    XMPPvCardAvatarModule *_avatar;//头像模块

}
@property(nonatomic, copy)XMPPResultBlock resultBlock;

@end

@implementation YCXMPPTool
singleton_implementation(YCXMPPTool)
- (XMPPStream *)xmppStream
{
    if (_xmppStream == nil) {
        _xmppStream = [[XMPPStream alloc] init];
        [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
        [self setupXMPP];
    }
    return _xmppStream;
}
- (void)setupXMPP
{
    _reconnect = [[XMPPReconnect alloc] init];
    [_reconnect activate:_xmppStream];
    
    _vCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    _vCardTempModule = [[XMPPvCardTempModule alloc] initWithvCardStorage:_vCardStorage];
    [_vCardTempModule activate:_xmppStream];
    
    _avatar = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:_vCardTempModule];
    [_avatar activate:_xmppStream];
    
    _rosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
    _roster = [[XMPPRoster alloc] initWithRosterStorage:_rosterStorage];
    [_roster activate:_xmppStream];
}


#pragma mark 释放xmppStream相关的资源
- (void)teardownXmpp{
    // 移除代理
    [_xmppStream removeDelegate:self];
    
    // 停止模块
    [_reconnect deactivate];
    [_vCardTempModule deactivate];
    [_avatar deactivate];
    [_roster deactivate];
    
    // 断开连接
    [_xmppStream disconnect];
    
    // 清空资源
    _reconnect = nil;
    _vCardTempModule = nil;
    _vCardStorage = nil;
    _avatar = nil;
    _roster = nil;
    _rosterStorage = nil;
    _xmppStream = nil;
    
}
- (void)dealloc
{
    [self teardownXmpp];
}

- (void)xmppConnectServerResultBlock:(XMPPResultBlock)resultBlock;
{
    [self connectToHost:resultBlock];
}

- (void)connectToHost:(XMPPResultBlock)resultBlock
{
    [self.xmppStream disconnect];
    self.resultBlock = resultBlock;
    switch ([YCUserInfo sharedYCUserInfo].connectType) {
        case YCConnectTypeOfConnectServer:
            [self connectToSeverWithUser:nil];
            break;
        case YCConnectTypeOfLogin:
            [self loginToSeverWithUser:[YCUserInfo sharedYCUserInfo].user];
            break;
        case YCConnectTypeOfRegister:
            [self registerToServerWithUser:[YCUserInfo sharedYCUserInfo].registerUser];
            break;
        case YCConnectTypeOfNone:
            break;
        default:
            break;
    }
}
- (void)connectToSeverWithUser:(NSString *)user
{
    NSString *domain = [YCUserInfo sharedYCUserInfo].domain;
    NSString *hostName = [YCUserInfo sharedYCUserInfo].hostName;
    int hostPort = [YCUserInfo sharedYCUserInfo].hostPort;
    if (domain.length == 0 || hostName.length == 0) return;
    XMPPJID *myJID = [XMPPJID jidWithUser:user domain:domain resource:@"iphone" ];
    self.xmppStream.myJID = myJID;
    self.xmppStream.hostName = hostName;//@"127.0.0.1" 不仅可以是域名，还可是IP地址
    self.xmppStream.hostPort = (UInt16)hostPort;
    NSError *error = nil;
    if (![self.xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        YCLog(@"%@",error);
    }
}
- (void)loginToSeverWithUser:(NSString *)user
{
    if (user.length == 0) return;
    [self connectToSeverWithUser:user];
}
#pragma mark -公共方法
-(void)xmppUserlogoutResultBlock:(XMPPResultBlock)resultBlock{
    // 1." 发送 "离线" 消息"
    self.resultBlock = resultBlock;
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offline];
    // 2. 与服务器断开连接
    [_xmppStream disconnect];
    
    [YC_UserDefaults setBool:NO forKey:YC_TagOfLoginSuccess];
    [YC_UserDefaults synchronize];
    [[YCUserInfo sharedYCUserInfo] setPwd:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        YCNavigationController *navi = [[YCNavigationController alloc] initWithRootViewController:[[YCConnectServerController alloc] init]];
        [UIApplication sharedApplication].keyWindow.rootViewController = navi;
    });
    
}

- (void)registerToServerWithUser:(NSString *)user
{
    if (user.length == 0) return;
    [self connectToSeverWithUser:user];
}
#pragma mark 连接到服务成功后，再发送密码授权
-(void)sendPwdToHost{
    YCLog(@"再发送密码授权");
    NSError *err = nil;
    
    // 从单例里获取密码
    NSString *pwd = [YCUserInfo sharedYCUserInfo].pwd;
    [self.xmppStream authenticateWithPassword:pwd error:&err];
    
    if (err) {
        YCLog(@"%@",err);
    }
}

#pragma mark  授权成功后，发送"在线" 消息
-(void)sendOnlineToHost{
    YCLog(@"发送 在线 消息");
    XMPPPresence *presence = [XMPPPresence presence];
    [self.xmppStream sendElement:presence];
}

#pragma mark -XMPPStream的代理
#pragma mark 与主机连接成功
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    YCLog(@"与主机连接成功");
    if ([YCUserInfo sharedYCUserInfo].connectType == YCConnectTypeOfConnectServer) {
        if (self.resultBlock) {
            self.resultBlock(XMPPResultTypeConnectServiceSuccess);
        }
    }
    else if ([YCUserInfo sharedYCUserInfo].connectType == YCConnectTypeOfLogin) {
        [self sendPwdToHost];
    }
    else if ([YCUserInfo sharedYCUserInfo].connectType == YCConnectTypeOfRegister) {
        NSString *registerP = [YCUserInfo sharedYCUserInfo].registerPwd;
        [self.xmppStream registerWithPassword:registerP error:nil];
    }
    
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    YCLog(@"与主机断开连接");
    if ([YCUserInfo sharedYCUserInfo].connectType == YCConnectTypeOfConnectServer) {
        if (self.resultBlock) {
            self.resultBlock(XMPPResultTypeConnectServiceFailure);
        }
    }
    else if ([YCUserInfo sharedYCUserInfo].connectType == YCConnectTypeOfLogout) {
        if (self.resultBlock) {
            self.resultBlock(XMPPResultTypeLogoutSuccess);
        }
    }
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    YCLog(@"授权成功");
    // 回调控制器登录成功
    if ([YCUserInfo sharedYCUserInfo].connectType == YCConnectTypeOfLogin) {
        [self sendOnlineToHost];
        if(self.resultBlock){
            self.resultBlock(XMPPResultTypeLoginSuccess);
        }
    }
    
}

#pragma mark 授权失败
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    YCLog(@"授权失败 %@",error);
    
    // 判断block有无值，再回调给登录控制器
    if ([YCUserInfo sharedYCUserInfo].connectType == YCConnectTypeOfLogin) {
        if(self.resultBlock){
            self.resultBlock(XMPPResultTypeLoginFailure);
        }
    }
}

#pragma mark 注册成功
-(void)xmppStreamDidRegister:(XMPPStream *)sender{
    YCLog(@"注册成功");
    if(self.resultBlock){
        self.resultBlock(XMPPResultTypeRegisterSuccess);
    }
}

#pragma mark 注册失败
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    
    YCLog(@"注册失败 %@",error);
    if(self.resultBlock){
        self.resultBlock(XMPPResultTypeRegisterFailure);
    }
    
}
@end








