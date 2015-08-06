//
//  YCBaseCell.h
//  YouChat
//
//  Created by Kowloon on 15/7/22.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YCBaseItem;
@interface YCBaseCell : UITableViewCell

@property(nonatomic, strong)YCBaseItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
