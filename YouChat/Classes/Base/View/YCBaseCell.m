//
//  YCBaseCell.m
//  YouChat
//
//  Created by Kowloon on 15/7/22.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCBaseCell.h"
#import "YCBaseItem.h"
#import "YCBaseArrowItem.h"
#import "YCBaseSwitchItem.h"
#import "YCRightImageItem.h"
@interface YCBaseCell ()

/**
 *  开关
 */
@property (nonatomic, strong) UISwitch *switchView;

@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation YCBaseCell

- (UIImageView *)rightImageView
{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        _rightImageView.layer.cornerRadius = 10;
        _rightImageView.clipsToBounds = YES;
    }
    return _rightImageView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}
/**
 *  监听开关状态改变
 */
- (void)switchStateChange
{
    [YC_UserDefaults setBool:self.switchView.isOn forKey:self.item.title];
    [YC_UserDefaults synchronize];
}


- (void)setItem:(YCBaseItem *)item
{
    _item = item;
    // 1.设置数据
    [self setupData];
    
    // 2.设置右边的内容
    [self setupRightContent];
}

/**
 *  设置数据
 */
- (void)setupData
{
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    else if (self.item.iconData) {
        self.imageView.image = [UIImage imageWithData:self.item.iconData];
    }
    self.textLabel.text = self.item.title;
    self.detailTextLabel.text = self.item.subtitle;
}
- (void)setupRightContent
{
    if ([self.item isKindOfClass:[YCBaseArrowItem class]]) { // 箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if ([self.item isKindOfClass:[YCBaseSwitchItem class]]) { // 开关
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 设置开关的状态
        self.switchView.on = [YC_UserDefaults boolForKey:self.item.title];
    }
    else if ([self.item isKindOfClass:[YCRightImageItem class]]) {
        YCRightImageItem *rightItem = (YCRightImageItem *)self.item;
        if (rightItem.rightImage) {
            self.rightImageView.image = [UIImage imageWithData:rightItem.rightImage];
        }
        else if (rightItem.rightIcon) {
            self.rightImageView.image = [UIImage imageNamed:rightItem.rightIcon];
        }
        self.accessoryView = self.rightImageView;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if ([self.item isKindOfClass:[YCBaseItem class]])//最初状态
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {//防止复用问题
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style
{
    static NSString *ID = @"base";
    YCBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!style) style = UITableViewCellStyleDefault;
    if (cell == nil) {
        cell = [[YCBaseCell alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageView.layer.cornerRadius = 10;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
@end







