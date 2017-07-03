//
//  UIView+SDFilterView.m
//  SDFilterViewDemo
//
//  Created by 陈克锋 on 2017/6/30.
//  Copyright © 2017年 陈克锋. All rights reserved.
//

#import "UIView+SDFilterView.h"
#import <objc/message.h>

@implementation UIView (SDFilterView)

- (UIViewController *)viewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)setFilterView:(SDFilterView *)filterView {
    objc_setAssociatedObject(self, @selector(setFilterView:), filterView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SDFilterView *)filterView {
    return objc_getAssociatedObject(self, @selector(setFilterView:));
}

@end
