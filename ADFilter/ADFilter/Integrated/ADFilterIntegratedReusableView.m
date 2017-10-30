//
//  ADFilterIntegratedReusableView.m
//  ADFilter
//
//  Created by 马乾征 on 2017/9/15.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterIntegratedReusableView.h"
#import "ADFilterCommon.h"

@implementation ADFilterIntegratedReusableView
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
    _contentLab.font = [ADFilterCommon systemFontOfSize:15 andWeight:UIFontWeightMedium];
    _contentLab.textColor = kAdFilterHexColor(0x2d2a2a);
    [self addSubview:_contentLab];
    
    [self makeConstraints];
}


- (void)makeConstraints {
    _contentLab.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *contentLabLeft = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:12];
    NSLayoutConstraint *contentLabRight = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-12];
    NSLayoutConstraint *contentLabTop = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:kAdFilterFloat(16)];
    [self addConstraints:@[contentLabLeft, contentLabRight, contentLabTop]];
}

- (void)fillData:(id)data {
    if (!data) {
        return;
    }
    _contentLab.text = data;
}
@end
