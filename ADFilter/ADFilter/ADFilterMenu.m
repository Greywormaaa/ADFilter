//
//  ADFilterMenuView.m
//  ADFilter
//
//  Created by 马乾征 on 2017/9/7.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterMenu.h"
#import "ADFilterMenu.h"

@implementation ADFilterMenu
{
    NSLayoutConstraint *_contentViewHeightConstraints;
}

+ (instancetype)menuWithTitle:(NSString *)title {
    ADFilterMenu *menu = [[self alloc] init];
    menu.title = title;
    return menu;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeSuper];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeSuper];
    }
    return self;
}

- (void)initializeSuper {
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    
    _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self addSubview:_backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapAction)];
    [_backgroundView addGestureRecognizer:tap];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    [self makeConstraintsSuper];
}

- (void)makeConstraintsSuper {
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *backgrountViewTop = [NSLayoutConstraint constraintWithItem:_backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *backgrountViewLeft = [NSLayoutConstraint constraintWithItem:_backgroundView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *backgrountViewRight = [NSLayoutConstraint constraintWithItem:_backgroundView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *backgrountViewBottom = [NSLayoutConstraint constraintWithItem:_backgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self addConstraints:@[backgrountViewTop, backgrountViewLeft, backgrountViewRight, backgrountViewBottom]];
    
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *contentViewTop = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *contentViewLeft = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *contentViewRight = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
   _contentViewHeightConstraints = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
    [self addConstraints:@[contentViewTop, contentViewLeft, contentViewRight]];
    [_contentView addConstraint:_contentViewHeightConstraints];
}

- (void)appearWithFrame:(CGRect)frame animation:(BOOL)animation {
    CGFloat contentHeight = [self contentHeight];
    _contentViewHeightConstraints.constant = contentHeight;
    [self setFrame:frame];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [self layoutIfNeeded];
    if (animation) {
        _backgroundView.alpha = 0;
        _contentView.transform = CGAffineTransformMakeTranslation(0, -contentHeight);
        CGFloat animateDuration = contentHeight / (CGRectGetHeight([UIScreen mainScreen].bounds) * 0.4) * 0.2 + 0.1;
        [UIView animateWithDuration:animateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _backgroundView.alpha = 1;
            _contentView.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)selectedItemAtSections:(NSArray <NSNumber *> *)sections {
    
}

- (void)selectedItemAtIndexPaths:(NSArray <NSIndexPath *> *)indexPaths {

}

- (void)reloadData {

}

- (void)disappearWithAnimation:(BOOL)animation {
    if (animation) {
        CGFloat contentHeight = [self contentHeight];
        _contentView.transform = CGAffineTransformMakeTranslation(0, -contentHeight);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _backgroundView.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else {
        [self removeFromSuperview];
    }
}

- (void)backgroundViewTapAction {
    [self disappearWithAnimation:NO];
    if ([self.delegate respondsToSelector:@selector(filterMenuDidClickOnTheBlank:)]) {
        [self.delegate filterMenuDidClickOnTheBlank:self];
    }
}
@end
