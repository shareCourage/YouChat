//
//  YCBaseArrowItem.h
//  YouChat
//
//  Created by Kowloon on 15/7/22.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCBaseItem.h"

@interface YCBaseArrowItem : YCBaseItem
/**
 *  点击这行cell需要跳转的控制器
 */
@property (nonatomic, assign) Class destVcClass;

+ (instancetype)arrowItemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;

+ (instancetype)arrowItemWithDataIcon:(NSData *)iconD title:(NSString *)title destVcClass:(Class)destVcClass;

+ (instancetype)arrowItemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;

@end
