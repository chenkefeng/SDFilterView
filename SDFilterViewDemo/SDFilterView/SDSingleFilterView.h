//
//  SDSingleFilterView.h
//  SDFilterViewDemo
//
//  Created by 陈克锋 on 2017/6/30.
//  Copyright © 2017年 陈克锋. All rights reserved.
//

#import "SDFilterView.h"

@class SDSingleFilterView;

@protocol SDSingleFilterViewDataSource <NSObject>

/// 行数
- (NSInteger)numberOfRow;

/**
 返回对应行数的cell

 @param filterView 过滤视图本身
 @param row 当前行
 @return 当前行对应的cell
 */
- (__kindof UITableViewCell *)filterView:(SDSingleFilterView *)filterView cellForRowAtRowIndex:(NSInteger)row;

@end

@protocol SDSingleFilterViewDelegate <SDFilterViewDelegate>
@optional
- (void)filterView:(SDSingleFilterView *)filterView didSelectedAtRow:(NSInteger)row withIdentifier:(NSString *)identifier;



@end

@interface SDSingleFilterView : SDFilterView

@property (nonatomic, weak) id<SDSingleFilterViewDataSource> dataSource;
@property (nonatomic, weak) id<SDSingleFilterViewDelegate> delegate;

/// 行高， 默认50
@property (nonatomic, assign) CGFloat rowHeight;


/// 重新刷新视图
- (void)reloadData;

- (__kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forRow:(NSInteger)row;

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

/// 滚动到指定行
- (void)scrollToIndex:(NSInteger)row animated:(BOOL)flag;

#pragma mark - override
/// 在弹出之前的contentView的frame
- (CGRect)initializeFrameForContentView;
/// 完全展示出来时的frame
- (CGRect)finalFrameForContentView;

@end
