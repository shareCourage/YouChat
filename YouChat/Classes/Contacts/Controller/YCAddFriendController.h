//
//  YCAddFriendController.h
//  YouChat
//
//  Created by Kowloon on 15/8/10.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCAddFriendController;

@protocol YCAddFriendControllerDelegate <NSObject>

@optional
- (void)addFriendController:(YCAddFriendController *)addFriendController didAddUser:(NSString *)user;

@end

@interface YCAddFriendController : UITableViewController

@property (nonatomic, assign) id<YCAddFriendControllerDelegate>delegate;

@end
