//
//  ADFilterIntegratedMuneItem.m
//  ADFilter
//
//  Created by 马乾征 on 2017/9/15.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterIntegratedMuneItem.h"
#import "ADFilterCommon.h"

@implementation ADFilterIntegratedMuneItem
{
    UILabel *_contentLab;
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
    _contentLab = [[UILabel alloc] init];
    _contentLab.textColor = kAdFilterHexColor(0x919090);
    _contentLab.font = kAdFilterFont(16);
    _contentLab.layer.masksToBounds = YES;
    _contentLab.layer.cornerRadius = kAdFilterFloat(4);
    _contentLab.layer.borderColor = kAdFilterHexColor(0x919090).CGColor;
    _contentLab.layer.borderWidth = 1;
    _contentLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_contentLab];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    _contentLab.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *contentLabLeft = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *contentLabRight = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *contentLabTop = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *contentLabBottom = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    [self.contentView addConstraints:@[contentLabLeft, contentLabRight, contentLabTop, contentLabBottom]];
}

- (void)fillData:(id)data {
    if (!data) {
        return;
    }
    _contentLab.text = data;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        _contentLab.textColor = kAdFilterHexColor(0xef7726);
        _contentLab.layer.borderColor = kAdFilterHexColor(0xef7726).CGColor;
    }
    else {
        _contentLab.textColor = kAdFilterHexColor(0x919090);
        _contentLab.layer.borderColor = kAdFilterHexColor(0x919090).CGColor;
    }
}
@end
