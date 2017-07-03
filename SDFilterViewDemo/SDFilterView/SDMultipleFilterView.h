//
//  SDMultipleFilterView.h
//  SDFilterViewDemo
//
//  Created by 陈克锋 on 2017/6/30.
//  Copyright © 2017年 陈克锋. All rights reserved.
//

#import "SDFilterView.h"

@class SDMultipleFilterView;

@protocol SDMultipleFilterViewDataSource <NSObject>

/**
 右侧视图的布局参数

 @param filterView 菜单视图本身
 @return 布局参数
 */
- (UICollectionViewLayout *)layoutForRightViewInFilterView:(SDMultipleFilterView *)filterView;

/**
 左侧视图的行数

 @param filterView 菜单
 @return 行数
 */
- (NSInteger)numberOfLeftViewInFilterView:(SDMultipleFilterView *)filterView;

/// 右侧视图的对应组的行数
- (NSInteger)numberOfRowAtRightViewInFilterView:(SDMultipleFilterView *)filterView atSection:(NSInteger)section;

/// 返回对应行的cell
- (__kindof UITableViewCell *)filterView:(SDMultipleFilterView *)filterView cellForLeftViewRowAtRow:(NSInteger)row;

/// 返回对应未知的collectionView的cell
- (__kindof UICollectionViewCell *)filterView:(SDMultipleFilterView *)filterView cellForRightViewRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 视图的高度
 */
- (CGFloat)heightForFilterView:(SDMultipleFilterView *)filterView;

/**
 右侧视图的组数， 默认一组
 */
@optional
- (NSInteger)numberOfSectionAtRightViewInFilterView:(SDMultipleFilterView *)filterView;

- (UICollectionReusableView *)filterView:(SDMultipleFilterView *)filterView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

/// 左侧视图占的比例，默认是: 1/3
- (CGFloat)leftViewRatioInFilterView:(SDMultipleFilterView *)filterView;

@end

@protocol SDMultipleFilterViewDelegate <SDFilterViewDelegate>
@optional
/// 左侧cell行高， 默认50
- (CGFloat)heightForRowInFilterViewLeftView:(SDMultipleFilterView *)filterView;

- (void)filterView:(SDMultipleFilterView *)filterView didSelectedAtRowInLeftView:(NSInteger)row;

- (void)filterView:(SDMultipleFilterView *)filterView didSelected:(NSInteger)leftViewIndex rightViewIndexPath:(NSIndexPath *)indexPath;



@end

@interface SDMultipleFilterView : SDFilterView

@property (nonatomic, weak) id<SDMultipleFilterViewDataSource> dataSource;
@property (nonatomic, weak) id<SDMultipleFilterViewDelegate> delegate;

@property (nonatomic, strong) UIColor *leftViewBgColor;
@property (nonatomic, strong) UIColor *rightViewBgColor;

#pragma mark - register
/// 注册左边cell
- (void)registerLeftClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

/**
 注册右侧cell

 @param cellClass UICollectionViewCell类型
 @param identifier 重用标志
 */
- (void)registerRightClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

/**
 注册collectionView的头部与底部视图

 @param viewClass 视图类
 @param elementKind UICollectionElementKindSectionHeader, UICollectionElementKindSectionFooter
 @param identifier 重用标志
 */
- (void)registerRightClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier;



#pragma mark - dequeue
/**
 获取注册了的左侧的cell

 @param identifier 重用标志
 @param row 当前行
 @return 当前的cell
 */
- (__kindof UITableViewCell *)dequeueLeftReusableCellWithIdentifier:(NSString *)identifier forRowAtRow:(NSInteger)row;


/**
 获取注册了的右侧的cell

 @param identifier 重用标志
 @param indexPath 未知
 @return collectionViewCell
 */
- (__kindof UICollectionViewCell *)dequeueRightReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

/**
 获取右侧CollectionView的头部与尾部视图

 @param elementKind UICollectionElementKindSectionHeader, UICollectionElementKindSectionFooter
 @param identifier 重用标志
 @param indexPath 未知
 @return 头部或尾部视图
 */
- (__kindof UICollectionReusableView *)dequeueRightReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;


#pragma mark - scrollTo
/// 左侧视图滚动到第几行
- (void)filterViewLeftViewScrollToRow:(NSInteger)row animated:(BOOL)flag;
/// 右侧视图滚动到的位置
- (void)filterViewRightViewScrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)flag;

@end
