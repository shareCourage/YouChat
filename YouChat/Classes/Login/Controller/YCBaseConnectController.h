//
//  YCBaseConnectController.h
//  YouChat
//
//  Created by Kowloon on 15/7/17.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^YCOptionBool)(BOOL success);

@interface YCBaseConnectController : UIViewController

/**
 *  供子类调用
 */
- (void)connect;

- (void)connectCompletion:(YCOptionBool)block;

- (void)jumpToMainWindow;

@end
