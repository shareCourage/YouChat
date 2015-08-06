//
//  YCTabBarController.m
//  YouChat
//
//  Created by Kowloon on 15/7/16.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCTabBarController.h"
#import "YCTabBar.h"
@interface YCTabBarController ()<YCTabBarDelegate>

@end

@implementation YCTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    YCTabBar *myTabBar = [[YCTabBar alloc] init];
    myTabBar.delegate = self;
    myTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:myTabBar];
    NSArray *tabBar = @[@"tabbar_mainframe",@"tabbar_contacts",@"tabbar_me"];
    NSArray *tabBarSel = @[@"tabbar_mainframeHL",@"tabbar_contactsHL",@"tabbar_meHL"];
    // 2.添加对应个数的按钮
    for (int i = 0; i < self.viewControllers.count; i++) {
        NSString *name = tabBar[i];
        NSString *selName = tabBarSel[i];
        [myTabBar addTabButtonWithName:name selName:selName];
    }
}

/**
 normal : 普通状态
 highlighted : 高亮(用户长按的时候达到这个状态)
 disable : enabled = NO
 selected :  selected = YES
 */
#pragma mark - PHTabBar的代理方法
- (void)tabBar:(YCTabBar *)tabBar didSelectButtonFrom:(NSUInteger)from to:(NSUInteger)to
{
    self.selectedIndex = to;
//    NSLog(@"%lu",(unsigned long)to);
}


@end
