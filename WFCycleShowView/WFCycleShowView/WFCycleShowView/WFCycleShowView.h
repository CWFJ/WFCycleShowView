//
//  WFCycleShowView.h
//  自定义广告栏控件
//
//  Created by 开发者 on 15/1/24.
//  Copyright (c) 2015年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFCycleShowView : UIView


/** 是否自动循环展示 */
@property (nonatomic, assign) BOOL            isAutoShow;

- (instancetype)initWithImages:(NSArray *)images;
+ (instancetype)cycleShowWithImages:(NSArray *)images;


- (instancetype)initWithImages:(NSArray *)images andSize:(CGSize)size;
+ (instancetype)cycleShowWithImages:(NSArray *)images andSize:(CGSize)size;
@end
