//
//  YCBaseItem.m
//  YouChat
//
//  Created by Kowloon on 15/7/22.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCBaseItem.h"

@implementation YCBaseItem


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    YCBaseItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}


+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}


+ (instancetype)itemWithDataIcon:(NSData *)iconD title:(NSString *)title
{
    YCBaseItem *item = [self itemWithIcon:nil title:title];
    item.iconData = iconD;
    return item;
}


@end




