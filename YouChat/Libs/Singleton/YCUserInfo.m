//
//  YCUserInfo.m
//  YouChat
//
//  Created by Kowloon on 15/7/17.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCUserInfo.h"





@implementation YCUserInfo

@synthesize hostName = _hostName;
@synthesize domain = _domain;
@synthesize hostPort = _hostPort;
@synthesize user = _user;
@synthesize pwd = _pwd;
singleton_implementation(YCUserInfo)

- (YCConnectType)connectType
{
    if (_connectType == 0) {
        _connectType = YCConnectTypeOfNone;
    }
    return _connectType;
}

- (NSString *)hostName
{
    if (_hostName == nil) {
        _hostName = [[NSUserDefaults standardUserDefaults] objectForKey:@"hostNameForKey"];
    }
    return _hostName;
}
- (void)setHostName:(NSString *)hostName
{
    _hostName = hostName;
    [[NSUserDefaults standardUserDefaults] setObject:hostName forKey:@"hostNameForKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setDomain:(NSString *)domain
{
    _domain = domain;
    [[NSUserDefaults standardUserDefaults] setObject:domain forKey:@"domainForKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)domain
{
    if (_domain == nil) {
        _domain = [[NSUserDefaults standardUserDefaults] objectForKey:@"domainForKey"];
    }
    return _domain;
}

- (void)setHostPort:(int)hostPort
{
    _hostPort = hostPort;
    [[NSUserDefaults standardUserDefaults] setInteger:(NSInteger)hostPort forKey:@"hostPortForKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (int)hostPort
{
    if (_hostPort == 0) {
        _hostPort = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"hostPortForKey"];
    }
    return _hostPort;
}

- (void)setUser:(NSString *)user
{
    _user = user;
    [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"userForKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)user
{
    if (_user == nil) {
        _user = [[NSUserDefaults standardUserDefaults] objectForKey:@"userForKey"];
    }
    return _user;
}

- (void)setPwd:(NSString *)pwd
{
    _pwd = pwd;
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:@"pwdForKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)pwd
{
    if (_pwd == nil) {
        _pwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"pwdForKey"];
    }
    return _pwd;
}
@end







