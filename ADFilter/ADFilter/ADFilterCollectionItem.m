//
//  ADCollectionItem.m
//  ADFilter
//
//  Created by 马乾征 on 2017/8/30.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterCollectionItem.h"

#pragma mark - base
#pragma mark -
@implementation ADFilterCollectionItem
- (void)fillData:(id)data{}
@end

#pragma mark - filter unit title
#pragma mark -
@implementation ADFilterUnitTitleItem
{
    UILabel *_titleLab;
    UIImageView *_leftLine;
    UIImageView *_rightLine;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _titleLab = [[UILabel alloc] init];
    _titleLab.textColor = [UIColor lightGrayColor];
    _titleLab.font = [UIFont systemFontOfSize:14];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLab];
    
    _leftLine = [[UIImageView alloc] init];
    _leftLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_leftLine];
    
    _rightLine = [[UIImageView alloc] init];
    _rightLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_rightLine];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    _titleLab.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *titleLabTop = [NSLayoutConstraint constraintWithItem:_titleLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *titleLabLeft = [NSLayoutConstraint constraintWithItem:_titleLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *titleLabRight = [NSLayoutConstraint constraintWithItem:_titleLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *titleLabBottom = [NSLayoutConstraint constraintWithItem:_titleLab attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[titleLabTop, titleLabLeft, titleLabRight, titleLabBottom]];
    
    _leftLine.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leftLineLeft = [NSLayoutConstraint constraintWithItem:_leftLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *leftLineCenterY = [NSLayoutConstraint constraintWithItem:_leftLine attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    NSLayoutConstraint *leftLineHeight = [NSLayoutConstraint constraintWithItem:_leftLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:0 constant:14];
    NSLayoutConstraint *leftLineWidth = [NSLayoutConstraint constraintWithItem:_leftLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.5];
    [self.contentView addConstraints:@[leftLineLeft, leftLineCenterY, leftLineWidth, leftLineHeight]];
    
    _rightLine.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *rightLineRight = [NSLayoutConstraint constraintWithItem:_rightLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *rightLineCenterY = [NSLayoutConstraint constraintWithItem:_rightLine attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    NSLayoutConstraint *rightLineHeight = [NSLayoutConstraint constraintWithItem:_rightLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:0 constant:14];
    NSLayoutConstraint *rightLineWidth = [NSLayoutConstraint constraintWithItem:_rightLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.5];
    [self.contentView addConstraints:@[rightLineRight, rightLineCenterY, rightLineHeight, rightLineWidth]];
    
}

- (void)fillData:(id)data {
    if (!data) {
        return;
    }
    _titleLab.text = data;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        _titleLab.textColor = [UIColor blackColor];
    }
    else {
        _titleLab.textColor = [UIColor lightGrayColor];
    }
    
}
@end
