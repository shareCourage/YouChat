//
//  YCBaseSwitchItem.m
//  YouChat
//
//  Created by Kowloon on 15/7/22.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCBaseSwitchItem.h"

@implementation YCBaseSwitchItem

+ (instancetype)switchItemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    YCBaseSwitchItem *switchItem = [self itemWithIcon:icon title:title];
    switchItem.destVcClass = destVcClass;
    return switchItem;
}

+ (instancetype)switchItemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self switchItemWithIcon:nil title:title destVcClass:destVcClass];
}

+ (instancetype)switchItemWithDataIcon:(NSData *)iconD title:(NSString *)title destVcClass:(Class)destVcClass
{
    YCBaseSwitchItem *switchItem = [self itemWithDataIcon:iconD title:title];
    switchItem.destVcClass = destVcClass;
    return switchItem;
}
@end
