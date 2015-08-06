//
//  YCBaseArrowItem.m
//  YouChat
//
//  Created by Kowloon on 15/7/22.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCBaseArrowItem.h"

@implementation YCBaseArrowItem


+ (instancetype)arrowItemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    YCBaseArrowItem *arrowItem = [self itemWithIcon:icon title:title];
    arrowItem.destVcClass = destVcClass;
    return arrowItem;
}

+ (instancetype)arrowItemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self arrowItemWithIcon:nil title:title destVcClass:destVcClass];
}

+ (instancetype)arrowItemWithDataIcon:(NSData *)iconD title:(NSString *)title destVcClass:(Class)destVcClass
{
    YCBaseArrowItem *arrowItem = [self itemWithDataIcon:iconD title:title];
    arrowItem.destVcClass = destVcClass;
    return arrowItem;
}


@end



