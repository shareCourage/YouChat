//
//  YCProfilerController.h
//  YouChat
//
//  Created by Kowloon on 15/7/22.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCBaseController.h"

@class YCProfilerController;
@protocol YCProfilerControllerDelegate <NSObject>

@optional
- (void)profilerControllerDidChanged:(YCProfilerController *)profiler;

@end

@interface YCProfilerController : YCBaseController

@property (nonatomic, assign) id<YCProfilerControllerDelegate>delegate;

@end
