//
//  UIView+Addition.h
//  CloudKnows
//
//  Created by atman on 13-5-7.
//  Copyright (c) 2013年 atman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

@property (nonatomic) UIColor *borderColor;

// The view controller whose view contains this view.
@property (nonatomic, readonly) UIViewController *viewController;

- (void)setTopBorderColor:(UIColor *)color;
- (void)setBottomBorderColor:(UIColor *)color;
- (void)setRightBorderColor:(UIColor *)color;
- (void)setLeftBorderColor:(UIColor *)color;

- (void)setOriginX:(CGFloat)x;
- (void)setOriginY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (BOOL)findAndResignFirstResponder;
- (id)  findFirstClass:(Class)cls;
- (id)  findFirstClass:(Class)cls bigThan:(float)wAndH;
- (void)showView:(UIView*)view onView:(UIView*)underView completeBlock:(dispatch_block_t) completeBlock;
- (void)removeShowingView;
- (void)removeTagView:(int)tag;
- (void)removeClassView:(Class)classType;
- (UIView*)getFocusView;

@end
