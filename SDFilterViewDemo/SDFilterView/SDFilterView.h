//
//  SDFilterView.h
//  SDFilterViewDemo
//
//  Created by 陈克锋 on 2017/6/30.
//  Copyright © 2017年 陈克锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SDFilterView.h"
@class SDFilterView;
@protocol SDFilterViewDelegate <NSObject>
@optional
- (void)filterViewWillShow:(SDFilterView *)filterView;
- (void)filterViewDidFinishShow:(SDFilterView *)filterView;

@end

@interface SDFilterView : UIView
{
    UIView *_sender;
}

+ (instancetype)filterViewWithSender:(UIView *)sender;

- (instancetype)initWithSender:(UIView *)sender;

/**
 内容视图
 */
@property(nonatomic, strong, readonly)UIView *contentView;


/**
 显示filterView

 @param flag 是否执行动画
 */
- (void)showAnimated:(BOOL)flag;

/**
 隐藏filterView

 @param flag 是否执行动画
 */
- (void)dismissAnimated:(BOOL)flag;

#pragma mark - override
/// 动画开始的状态（相对于show来说）
- (void)initializeForAnimated;
/// 动画结束的状态（相对于show来说）
- (void)finalForAnimated;

- (void)willShow;
- (void)didShow;

- (void)willHide;
- (void)didHide;


@end
