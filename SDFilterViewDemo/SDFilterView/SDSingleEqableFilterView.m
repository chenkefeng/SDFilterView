//
//  SDSingleEqableFilterView.m
//  SDFilterViewDemo
//
//  Created by 陈克锋 on 2017/6/30.
//  Copyright © 2017年 陈克锋. All rights reserved.
//

#import "SDSingleEqableFilterView.h"

@implementation SDSingleEqableFilterView

- (CGRect)initializeFrameForContentView {
    CGRect contentViewRect = [super initializeFrameForContentView];
    return CGRectMake(CGRectGetMinX(_sender.frame), -CGRectGetHeight(contentViewRect), CGRectGetWidth(_sender.frame), CGRectGetHeight(contentViewRect));
}

- (CGRect)finalFrameForContentView {
    CGRect contentViewRect = [super finalFrameForContentView];
    return CGRectMake(CGRectGetMinX(_sender.frame),0, CGRectGetWidth(_sender.frame), CGRectGetHeight(contentViewRect));
}

@end
