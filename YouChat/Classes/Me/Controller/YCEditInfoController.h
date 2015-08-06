//
//  YCEditInfoController.h
//  YouChat
//
//  Created by Kowloon on 15/7/27.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCEditInfoController;
@protocol YCEditInfoControllerDelegate <NSObject>

@optional
- (void)editInfoController:(YCEditInfoController *)profilerController DidSaveTitle:(NSString *)title;

@end
@interface YCEditInfoController : UITableViewController

@property(nonatomic, copy)NSString *editTitle;
@property(nonatomic, assign)id<YCEditInfoControllerDelegate>delegate;

@end





