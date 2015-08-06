//
//  YCEditCell.h
//  YouChat
//
//  Created by Kowloon on 15/7/28.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCEditCell : UITableViewCell

@property (nonatomic, copy)NSString *editTitle;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
