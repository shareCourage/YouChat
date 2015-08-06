//
//  YCRightImageItem.m
//  YouChat
//
//  Created by Kowloon on 15/7/27.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCRightImageItem.h"

@implementation YCRightImageItem


+ (instancetype)rightItemWithTitle:(NSString *)title image:(NSData *)image
{
    YCRightImageItem *right = [self itemWithTitle:title];
    right.rightImage = image;
    return right;
}

@end
