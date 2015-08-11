//
//  YCBaseController.h
//  YouChat
//
//  Created by Kowloon on 15/7/22.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YCBaseItem;

@interface YCBaseController : UITableViewController


@property(nonatomic, strong)NSMutableArray *dataSource;

- (void)pushVCWithClass:(Class)destClass settingItem:(YCBaseItem *)item;

@end
