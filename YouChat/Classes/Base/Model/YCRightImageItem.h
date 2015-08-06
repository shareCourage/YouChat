//
//  YCRightImageItem.h
//  YouChat
//
//  Created by Kowloon on 15/7/27.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCBaseItem.h"

@interface YCRightImageItem : YCBaseItem


@property(nonatomic, strong)NSData *rightImage;

@property(nonatomic, copy)NSString *rightIcon;

+ (instancetype)rightItemWithTitle:(NSString *)title image:(NSData *)image;

@end
