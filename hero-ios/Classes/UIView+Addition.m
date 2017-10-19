//
//  UIView+Addition.m
//  CloudKnows
//
//  Created by atman on 13-5-7.
//  Copyright (c) 2013年 atman. All rights reserved.
//

#import "UIView+Addition.h"
@interface BlockContainner : UIView
@property (nonatomic,strong) dispatch_block_t block;
-(void)fireBlock:(id)sender;
@end
@implementation BlockContainner
-(void)fireBlock:(id)sender
{
    [self.superview removeFromSuperview];
    self.block();
}
@end

@implementation UIView (Addition)
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderWidth = 1;
    self.layer.borderColor = [borderColor CGColor];
}

- (UIViewController *)viewController {
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)setTopBorderColor:(UIColor *)color {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = color;
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:line];
    
    [self addPositionConstraintWithItem:line attribute:NSLayoutAttributeTop];
    [self addPositionConstraintWithItem:line attribute:NSLayoutAttributeLeft];
    [self addPositionConstraintWithItem:line attribute:NSLayoutAttributeRight];
    [self addFixedSizeConstraintWithItem:line attribute:NSLayoutAttributeHeight];
}

- (void)setBottomBorderColor:(UIColor *)color {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = color;
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:line];
    
    [self addPositionConstraintWithItem:line attribute:NSLayoutAttributeBottom];
    [self addPositionConstraintWithItem:line attribute:NSLayoutAttributeLeft];
    [self addPositionConstraintWithItem:line attribute:NSLayoutAttributeRight];
    [self addFixedSizeConstraintWithItem:line attribute:NSLayoutAttributeHeight];
}

- (void)setRightBorderColor:(UIColor *)color {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = color;
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:line];
    
    [self addPositionConstraintWithItem:line attribute:NSLayoutAttributeTop];
    [self addPositionConstraintWithItem:line attribute:NSLayoutAttributeBottom];
    [self addPositionConstraintWithItem:line attribute:NSLayoutAttributeRight];
    [self addFixedSizeConstraintWithItem:line attribute:NSLayoutAttributeWidth];
}

- (void)setLeftBorderColor:(UIColor *)color {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = color;
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:line];
    
    [self addPositionConstraintWithItem:line attribute:NSLayoutAttributeTop];
    [self addPositionConstraintWithItem:line attribute:NSLayoutAttributeBottom];
    [self addPositionConstraintWithItem:line attribute:NSLayoutAttributeLeft];
    [self addFixedSizeConstraintWithItem:line attribute:NSLayoutAttributeWidth];
}

- (void)addPositionConstraintWithItem:(UIView *)item attribute:(NSLayoutAttribute)attribute {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self attribute:attribute multiplier:1.0 constant:0];
    [self addConstraint:constraint];
}

- (void)addFixedSizeConstraintWithItem:(UIView *)item attribute:(NSLayoutAttribute)attribute {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:attribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.5];
    [self addConstraint:constraint];
}

- (void)setOriginX:(CGFloat)x{
    [self setFrame:CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
}

- (void)setOriginY:(CGFloat)y{
    [self setFrame:CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height)];
}


- (BOOL)findAndResignFirstResponder
{
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if ([subView findAndResignFirstResponder])
            return YES;
    }
    return NO;
}
- (id)findFirstClass:(Class)cls
{
    for (UIView *view in self.subviews) {
        if ([view class] == cls) {
            return view;
        }
        else
        {
            UIView *v = [view findFirstClass:cls];
            if (v) {
                return v;
            }
        }
    }
    return NULL;
}
- (id)findFirstClass:(Class)cls bigThan:(float)wAndH
{
    for (UIView *view in self.subviews) {
        if ([view class] == cls && view.bounds.size.width > wAndH && view.bounds.size.height > wAndH) {
            return view;
        }
        else
        {
            UIView *v = [view findFirstClass:cls bigThan:wAndH];
            if (v) {
                return v;
            }
        }
    }
    return NULL;
}
- (void)showView:(UIView*)view onView:(UIView*)underView completeBlock:(dispatch_block_t) completeBlock
{
    UIButton *u = [[UIButton alloc]initWithFrame:self.bounds];
    u.tag = 100123;
    [self addSubview:u];
    BlockContainner *block = [[BlockContainner alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    block.block = completeBlock;
    [u addTarget:block action:@selector(fireBlock:) forControlEvents:UIControlEventTouchDown];
    [u addSubview:block];
    CGRect rect = [underView.superview convertRect:underView.frame toView:self];
    rect.origin.y -= view.bounds.size.height;
    rect.size.height = view.bounds.size.height;
    view.frame = rect;
    [u addSubview:view];
}
- (void)removeShowingView
{
    UIView *v = [self viewWithTag:100123];
    [v removeFromSuperview];
}
- (void)removeTagView:(int)tag
{
    while ([self viewWithTag:tag]) {
        UIView *v = [self viewWithTag:tag];
        [v removeFromSuperview];
    }
}
- (void)removeClassView:(Class)classType
{
    for (UIView *view in self.subviews) {
        if ([view class] == classType) {
            view.tag = 107876;
        }
    }
    [self removeTagView:107876];
}
-(UIView*)getFocusView
{
    if ([self isFirstResponder]) {
        return self;
    }
    else
    {
        for (UIView *v in self.subviews) {
            UIView *v1 = [v getFocusView];
            if (v1) {
                return v1;
            }
        }
    }
    return nil;
}

@end
