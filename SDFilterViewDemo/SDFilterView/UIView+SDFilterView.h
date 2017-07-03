//
//  UIView+SDFilterView.h
//  SDFilterViewDemo
//
//  Created by 陈克锋 on 2017/6/30.
//  Copyright © 2017年 陈克锋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDFilterView;
@interface UIView (SDFilterView)

@property (nonatomic, weak, readonly)UIViewController *viewController;

@property (nonatomic, strong)SDFilterView *filterView;

@end
