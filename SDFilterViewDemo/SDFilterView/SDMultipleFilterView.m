//
//  SDMultipleFilterView.m
//  SDFilterViewDemo
//
//  Created by 陈克锋 on 2017/6/30.
//  Copyright © 2017年 陈克锋. All rights reserved.
//

#import "SDMultipleFilterView.h"

@interface SDMultipleFilterView () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger leftViewSelectedRow;

@end

@implementation SDMultipleFilterView


- (instancetype)initWithSender:(UIView *)sender {
    if (self = [super initWithSender:sender]) {
        [self sd_multiple_filterView_setup];
    }
    return self;
}


- (void)initializeForAnimated {
    
    
    [super initializeForAnimated];
    [self.collectionView setCollectionViewLayout:[self.dataSource layoutForRightViewInFilterView:self]];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    self.contentView.frame = CGRectMake(0, -[self.dataSource heightForFilterView:self], screenW, [self.dataSource heightForFilterView:self]);
    
}

- (void)finalForAnimated {
    
    [super finalForAnimated];
    CGRect rect = self.contentView.frame;
    rect.origin.y = 0;
    self.contentView.frame = rect;
}

#pragma mark - override
- (void)willShow {
    if ([self.delegate respondsToSelector:@selector(filterViewWillShow:)]) {
        [self.delegate filterViewWillShow:self];
    }
}

- (void)didShow {
    if ([self.delegate respondsToSelector:@selector(filterViewDidFinishShow:)]) {
        [self.delegate filterViewDidFinishShow:self];
    }
}

#pragma mark - private
- (void)sd_multiple_filterView_setup {
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.collectionView];
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat leftViewWidth = screenW / 3;
    
    if ([self.dataSource respondsToSelector:@selector(leftViewRatioInFilterView:)]) {
        leftViewWidth = [UIScreen mainScreen].bounds.size.width * [self.dataSource leftViewRatioInFilterView:self];
    }
    
    self.tableView.frame = CGRectMake(0, 0, leftViewWidth, CGRectGetHeight(self.contentView.frame));
    self.collectionView.frame = CGRectMake(leftViewWidth, 0, screenW - leftViewWidth, CGRectGetHeight(self.contentView.frame));
    
}


#pragma mark - register

- (void)registerLeftClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [self.tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)registerRightClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (void)registerRightClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier {
    [self.collectionView registerClass:viewClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier];
}

#pragma mark - dequeue

- (UITableViewCell *)dequeueLeftReusableCellWithIdentifier:(NSString *)identifier forRowAtRow:(NSInteger)row {
    return [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
}

- (UICollectionViewCell *)dequeueRightReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

- (UICollectionReusableView *)dequeueRightReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    
    return [self.collectionView dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier forIndexPath:indexPath];
}

#pragma mark - scrollTo
- (void)filterViewLeftViewScrollToRow:(NSInteger)row animated:(BOOL)flag{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:flag];
}

- (void)filterViewRightViewScrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)flag {
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:flag];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfLeftViewInFilterView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource filterView:self cellForLeftViewRowAtRow:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(heightForRowInFilterViewLeftView:)]) {
        return [self.delegate heightForRowInFilterViewLeftView:self];
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.leftViewSelectedRow = indexPath.row;
    if ([self.delegate respondsToSelector:@selector(filterView:didSelectedAtRowInLeftView:)]) {
        [self.delegate filterView:self didSelectedAtRowInLeftView:indexPath.row];
    }
}

#pragma mark - UICollectionViewDataSource， UICollectionViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionAtRightViewInFilterView:)]) {
        return [self.dataSource numberOfSectionAtRightViewInFilterView:self];
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowAtRightViewInFilterView:self atSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource filterView:self cellForRightViewRowAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(filterView:didSelected:rightViewIndexPath:)]) {
        [self.delegate filterView:self didSelected:self.leftViewSelectedRow rightViewIndexPath:indexPath];
    }
}

#pragma mark - setter
- (void)setLeftViewBgColor:(UIColor *)leftViewBgColor {
    _leftViewBgColor = leftViewBgColor;
    self.tableView.backgroundColor = leftViewBgColor;
}

- (void)setRightViewBgColor:(UIColor *)rightViewBgColor {
    _rightViewBgColor = rightViewBgColor;
    self.collectionView.backgroundColor = rightViewBgColor;
}


#pragma mark - lazy
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    }
    return _collectionView;
}



@end
