//
//  SDFilterView.m
//  SDFilterViewDemo
//
//  Created by 陈克锋 on 2017/6/30.
//  Copyright © 2017年 陈克锋. All rights reserved.
//

#import "SDFilterView.h"

@interface SDFilterView () <UIGestureRecognizerDelegate>
@property(nonatomic, strong)UIView *contentView;
@end

@implementation SDFilterView

+ (instancetype)filterViewWithSender:(UIView *)sender {
    return [[self alloc] initWithSender:sender];
}

- (instancetype)initWithSender:(UIView *)sender {
    
    if (self = [super init]) {
        _sender = sender;
        [self sd_filterView_setup];
    }
    return self;
}

- (void)showAnimated:(BOOL)flag {
    
    if (_sender.filterView) {
        return;
    }
    
    NSTimeInterval duration = 0;
    if (flag) {
        duration = 0.35;
    }
    [self willShow];
    
    _sender.filterView = self;
    [_sender.viewController.view addSubview:self];
    self.alpha = 0.0;
    [self initializeForAnimated];
    
    [UIView animateWithDuration:duration animations:^{
        [self finalForAnimated];
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self didShow];
    }];
}

- (void)dismissAnimated:(BOOL)flag {
    [self willHide];
    NSTimeInterval duration = 0;
    if (flag) {
        duration = 0.35;
    }
    self.alpha = 1.0;
    [self finalForAnimated];
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.0;
        [self initializeForAnimated];
    } completion:^(BOOL finished) {
        _sender.filterView = nil;
        [self removeFromSuperview];
        [self didHide];
    }];

}

- (void)willShow {
    
}

- (void)didShow {
    
}

- (void)willHide {
    
}

- (void)didHide {
    
}

#pragma mark - 私有方法

- (void)sd_filterView_setup {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onViewDidTap:)];
    tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:tapGestureRecognizer];
    
    CGRect rect = [_sender convertRect:_sender.frame toView:_sender.viewController.view];
    
    self.frame = CGRectMake(0, CGRectGetMaxY(rect), CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetMaxY(rect));
    
    self.clipsToBounds = YES;
    [self addSubview:self.contentView];
}

- (void)onViewDidTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self dismissAnimated:YES];
}

#pragma mark - 代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self];
    CGPoint targetPoint = [self convertPoint:point toView:self.contentView];
    
    if (CGRectContainsPoint(self.contentView.bounds, targetPoint)) {
        return false;
    }
    
    
    return true;
}

- (void)finalForAnimated {
    
}

- (void)initializeForAnimated {
    
}

- (UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}


@end
