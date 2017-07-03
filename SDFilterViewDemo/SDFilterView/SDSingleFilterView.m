//
//  SDSingleFilterView.m
//  SDFilterViewDemo
//
//  Created by 陈克锋 on 2017/6/30.
//  Copyright © 2017年 陈克锋. All rights reserved.
//

#import "SDSingleFilterView.h"

@interface SDSingleFilterView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SDSingleFilterView

- (instancetype)initWithSender:(UIView *)sender {
    if (self = [super initWithSender:sender]) {
        [self sd_singlefilterView_setup];
    }
    return self;
}

- (void)initializeForAnimated {
    [super initializeForAnimated];
    
    self.contentView.frame = [self initializeFrameForContentView];
}

- (void)finalForAnimated {
    [super finalForAnimated];
    self.contentView.frame = [self finalFrameForContentView];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forRow:(NSInteger)row {
    return [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
}

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [self.tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)scrollToIndex:(NSInteger)row animated:(BOOL)flag {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:flag];
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

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(numberOfRow)]) {
        return [self.dataSource numberOfRow];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource filterView:self cellForRowAtRowIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(filterView:didSelectedAtRow:withIdentifier:)]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self.delegate filterView:self didSelectedAtRow:indexPath.row withIdentifier:cell.reuseIdentifier];
    }
}

#pragma mark - 私有方法
- (void)sd_singlefilterView_setup {
    
    [self.contentView addSubview:self.tableView];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableArray *constraints =  [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:kNilOptions metrics:nil views:@{@"tableView":self.tableView}].mutableCopy;
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|" options:kNilOptions metrics:nil views:@{@"tableView":self.tableView}]];
    
    [self.contentView addConstraints:constraints];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

- (CGFloat)sd_calcContentViewHeight {
    CGFloat heigth = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfRow)]) {
        heigth = [self.dataSource numberOfRow] * self.tableView.rowHeight;
    }
    CGFloat selfHeight = CGRectGetHeight(self.frame);
    
    NSInteger maxRow = selfHeight / self.tableView.rowHeight;
    
    if (heigth > (maxRow - 2) * self.tableView.rowHeight) {
        heigth = (maxRow - 2) * self.tableView.rowHeight;
    }
    return heigth;
}

- (CGFloat)heightForContentView {
    return [self sd_calcContentViewHeight];
}

- (CGRect)initializeFrameForContentView {
    CGFloat height = [self heightForContentView];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return CGRectMake(0, -height, width, height);
}

- (CGRect)finalFrameForContentView {
    CGFloat height = [self heightForContentView];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return CGRectMake(0, 0, width, height);
}

#pragma mark - lazy

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.rowHeight = 50;
    }
    return _tableView;
}

- (void)setRowHeight:(CGFloat)rowHeight {
    _rowHeight = rowHeight;
    self.tableView.rowHeight = rowHeight;
}

@end
