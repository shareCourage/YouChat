//
//  YCBaseItem.h
//  YouChat
//
//  Created by Kowloon on 15/7/22.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef  void (^YCBaseItemOption)(void);

@interface YCBaseItem : NSObject

@property(nonatomic, copy)NSString *icon;

@property(nonatomic, strong)NSData *iconData;

@property(nonatomic, copy)NSString *title;

@property(nonatomic, copy)NSString *subtitle;

@property(nonatomic, copy)YCBaseItemOption option;


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

+ (instancetype)itemWithDataIcon:(NSData *)iconD title:(NSString *)title;

+ (instancetype)itemWithTitle:(NSString *)title;

@end
