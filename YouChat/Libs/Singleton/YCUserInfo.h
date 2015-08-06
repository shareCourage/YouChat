//
//  YCUserInfo.h
//  YouChat
//
//  Created by Kowloon on 15/7/17.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

typedef enum {
    YCConnectTypeOfConnectServer = 900,
    YCConnectTypeOfRegister,
    YCConnectTypeOfLogin,
    YCConnectTypeOfLogout,
    YCConnectTypeOfNone
}YCConnectType;

@interface YCUserInfo : NSObject
singleton_interface(YCUserInfo)

@property(nonatomic, copy)NSString *domain;
@property(nonatomic, copy)NSString *hostName;
@property(nonatomic, assign)int hostPort;//端口号


@property (nonatomic, copy) NSString *user;//用户名
@property (nonatomic, copy) NSString *pwd;//密码

@property (nonatomic, copy) NSString *registerUser;//注册的用户名
@property (nonatomic, copy) NSString *registerPwd;//注册的密码

@property (nonatomic, assign)YCConnectType connectType;



@end





