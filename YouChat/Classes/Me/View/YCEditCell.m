//
//  YCEditCell.m
//  YouChat
//
//  Created by Kowloon on 15/7/28.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCEditCell.h"

@interface YCEditCell ()
@property (weak, nonatomic) IBOutlet UITextField *editTextField;

@end

@implementation YCEditCell

@synthesize editTitle = _editTitle;
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"edit";
    YCEditCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    return cell;
}
- (void)setEditTitle:(NSString *)editTitle
{
    _editTitle = editTitle;
    self.editTextField.text = editTitle;
}
- (NSString *)editTitle
{
    _editTitle = self.editTextField.text;
    return _editTitle;
}

@end






