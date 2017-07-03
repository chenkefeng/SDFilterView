//
//  ViewController.m
//  SDFilterViewDemo
//
//  Created by 陈克锋 on 2017/6/30.
//  Copyright © 2017年 陈克锋. All rights reserved.
//

#import "ViewController.h"
#import "SDSingleEqableFilterView.h"

#import "SDMultipleFilterView.h"

@interface MMItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isSelected;

@end

@implementation MMItem



@end

@interface ViewController () <SDSingleFilterViewDataSource, SDSingleFilterViewDelegate, SDMultipleFilterViewDataSource, SDMultipleFilterViewDelegate>

@property (nonatomic, strong) NSArray<MMItem *> *dataList;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSInteger index = 0; index < 20; index++) {
        MMItem *item = [[MMItem alloc] init];
        item.title = [NSString stringWithFormat:@"item%ld", index];
        item.isSelected = index == 0;
        [arr addObject:item];
    }
    
    self.dataList = arr.copy;
    
}

- (IBAction)onButtonDidTap:(UIButton *)sender {
    if (sender.tag == 0) {
        [self handlerSingleStyle:sender];
        return;
    }
    [self handlerMultipleStype:sender];
}

- (void)handlerMultipleStype:(UIButton *)sender {
    if (sender.filterView) {
        [sender.filterView dismissAnimated:YES];
        return;
    }
    SDMultipleFilterView *filterView = [SDMultipleFilterView filterViewWithSender:sender];
    filterView.dataSource = self;
    filterView.delegate = self;
    [filterView registerLeftClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    [filterView registerRightClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ID"];
    [filterView showAnimated:YES];
    
}


- (UICollectionViewLayout *)layoutForRightViewInFilterView:(SDMultipleFilterView *)filterView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 3 * 2;
    layout.itemSize = CGSizeMake(width, 50);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 1;
    
    return layout;
}


- (NSInteger)numberOfLeftViewInFilterView:(SDMultipleFilterView *)filterView {
    return 20;
}

- (NSInteger)numberOfRowAtRightViewInFilterView:(SDMultipleFilterView *)filterView atSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)filterView:(SDMultipleFilterView *)filterView cellForLeftViewRowAtRow:(NSInteger)row {
    UITableViewCell *cell = [filterView dequeueLeftReusableCellWithIdentifier:@"ID" forRowAtRow:row];
    cell.textLabel.text = [NSString stringWithFormat:@"哈哈哈%ld", row];
    return cell;
}

- (UICollectionViewCell *)filterView:(SDMultipleFilterView *)filterView cellForRightViewRowAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [filterView dequeueRightReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (CGFloat)heightForFilterView:(SDMultipleFilterView *)filterView {
    return 50 * 8;
}


- (void)filterView:(SDMultipleFilterView *)filterView didSelected:(NSInteger)leftViewIndex rightViewIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld-----%@", leftViewIndex, indexPath);
}











- (void)handlerSingleStyle:(UIButton *)sender {
    if (sender.filterView) {
        [sender.filterView dismissAnimated:YES];
        return;
    }
    SDSingleFilterView *filterView = [SDSingleFilterView filterViewWithSender:sender];
    filterView.dataSource = self;
    filterView.delegate = self;
    [filterView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [filterView showAnimated:YES];
}

- (NSInteger)numberOfRow {
    return self.dataList.count;
}

- (UITableViewCell *)filterView:(SDSingleFilterView *)filterView cellForRowAtRowIndex:(NSInteger)row {
    UITableViewCell *cell = [filterView dequeueReusableCellWithIdentifier:@"cellID" forRow:row];
    
    MMItem *item = self.dataList[row];
    
    if (item.isSelected) {
        cell.textLabel.textColor = [UIColor orangeColor];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    cell.textLabel.text = item.title;
    
    return cell;
}

- (void)filterView:(SDSingleFilterView *)filterView didSelectedAtRow:(NSInteger)row withIdentifier:(NSString *)identifier {
    [self.dataList enumerateObjectsUsingBlock:^(MMItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelected = false;
    }];
    
    self.dataList[row].isSelected = true;
    
    [filterView dismissAnimated:YES];
}

- (void)filterViewWillShow:(SDFilterView *)filterView {
    [self.btn1.filterView dismissAnimated:NO];
    [self.btn2.filterView dismissAnimated:NO];
    [self.btn3.filterView dismissAnimated:NO];
    
//    [filterView scrollToIndex:18 animated:NO];
    
}

@end
