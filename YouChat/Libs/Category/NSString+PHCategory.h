//
//  NSString+PHCategory.h
//  SimplifiedApp
//
//  Created by Kowloon on 15/5/21.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PHCategory)



- (NSString *)MD5;
- (NSString *)myMD5;
- (NSString *)SHA1;//SHA1加密
- (BOOL)isTelphoneNum;


/*
 *MD%加密
 */
+ (NSString*)getSignForMD5:(NSString*)info;

+ (NSString *)uuid;//uuid

+ (NSString *)currentDeviceNSUUID;//vendor

+ (NSString *)iPhoneDeviceNumber;//设备是iPhone几，比如iPhone6

/**
 *  根据系统的时区，获取一个数值，比如beijing 28800 Tokyo 32400
 *
 */
+ (NSString *)getNowDateTimezone;

@end




