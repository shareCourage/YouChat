//
//  YCRegisterController.h
//  YouChat
//
//  Created by Kowloon on 15/7/17.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCBaseConnectController.h"

@class YCRegisterController;
@protocol  YCRegisterControllerDelegate<NSObject>

-(void)regisgerViewControllerDidFinishRegister;

@end

@interface YCRegisterController : YCBaseConnectController

@property(nonatomic, assign, getter = isLogin)BOOL login;
@property(nonatomic, assign)id<YCRegisterControllerDelegate> delegate;

@end
