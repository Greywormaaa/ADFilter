//
//  ADFilterDoubleMenuTableCell.m
//  ADFilter
//
//  Created by 马乾征 on 2017/9/15.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterDoubleMenuTableCell.h"
#import "ADFilterCommon.h"

@implementation ADFilterDoubleMenuTableCell
- (void)fillData:(id)data {}
@end


@implementation ADFilterDoubleMenuParentCell
{
    UILabel *_contentLab;
    UIImageView *_bottomLine;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void) initialize {
    
    self.separatorInset = UIEdgeInsetsZero;
    self.contentView.backgroundColor = kAdFilterHexColor(0xf5f5f5);
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = backgroundView;
    
    _contentLab = [[UILabel alloc] init];
    _contentLab.textColor = kAdFilterHexColor(0x2d2a2a);
    _contentLab.font = kAdFilterFont(16);
    _contentLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_contentLab];
    
    _bottomLine = [[UIImageView alloc] init];
    _bottomLine.backgroundColor = kAdFilterHexColor(0xdddddd);
    [self.contentView addSubview:_bottomLine];
    
    [self makeConstraints];
}


- (void)makeConstraints {
    _contentLab.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *contentLabTop = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *contentLabLeft = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *contentLabRight = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *contentLabBottom = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[contentLabTop, contentLabLeft, contentLabRight, contentLabBottom]];
    
    _bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *bottomLineBottom = [NSLayoutConstraint constraintWithItem:_bottomLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomLineLeft = [NSLayoutConstraint constraintWithItem:_bottomLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomLineRight = [NSLayoutConstraint constraintWithItem:_bottomLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomLineHeight = [NSLayoutConstraint constraintWithItem:_bottomLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil  attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.5];
    [self.contentView addConstraints:@[bottomLineLeft, bottomLineRight, bottomLineBottom]];
    [_bottomLine addConstraint:bottomLineHeight];
}

- (void)fillData:(id)data {
    if (!data) {
        return;
    }
    _contentLab.text = data;
}


@end


@implementation ADFilterDoubleMenuChildCell
{
    UILabel *_contentLab;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void) initialize {
    
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth([UIScreen mainScreen].bounds));
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _contentLab = [[UILabel alloc] init];
    _contentLab.textColor = kAdFilterHexColor(0x565353);
    _contentLab.font = kAdFilterFont(15);
    _contentLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_contentLab];
    
    [self makeConstraints];
}


- (void)makeConstraints {
    _contentLab.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *contentLabTop = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *contentLabLeft = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *contentLabRight = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *contentLabBottom = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[contentLabTop, contentLabLeft, contentLabRight, contentLabBottom]];
}

- (void)fillData:(id)data {
    if (!data) {
        return;
    }
    _contentLab.text = data;
}


@end
