//
//  YCTabBar.h
//  YouChat
//
//  Created by Kowloon on 15/7/16.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YCTabBar;

@protocol YCTabBarDelegate <NSObject>

@optional
- (void)tabBar:(YCTabBar *)tabBar didSelectButtonFrom:(NSUInteger)from to:(NSUInteger)to;

@end

@interface YCTabBar : UIView

@property (nonatomic, weak)id<YCTabBarDelegate>delegate;

/**
 *  用来添加一个内部的按钮
 *
 *  @param name    按钮图片
 *  @param selName 按钮选中时的图片
 */
- (void)addTabButtonWithName:(NSString *)name selName:(NSString *)selName;

@end
