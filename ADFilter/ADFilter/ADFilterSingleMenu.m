//
//  ADFilterMenuSingleView.m
//  ADFilter
//
//  Created by 马乾征 on 2017/9/8.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterSingleMenu.h"
#import "ADFilterCommon.h"

@interface ADFilterMenuSingleViewCell : UITableViewCell
- (void)fillData:(id)data;
@end
@implementation ADFilterMenuSingleViewCell
{
    UILabel *_contentLab;
    UIImageView *_bottomLine;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.separatorInset = UIEdgeInsetsZero;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _contentLab = [[UILabel alloc] init];
    _contentLab.textColor = kAdFilterHexColor(0x2d2a2a);
    _contentLab.font = kAdFilterFont(16);
    [self.contentView addSubview:_contentLab];
    
    _bottomLine = [[UIImageView alloc] init];
    _bottomLine.backgroundColor = kAdFilterHexColor(0xdddddd);
    [self.contentView addSubview:_bottomLine];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    _contentLab.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *contentLabLeft = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:12];
    NSLayoutConstraint *contentLabRight = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-12];
    NSLayoutConstraint *contentLabCenterY = [NSLayoutConstraint constraintWithItem:_contentLab attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[contentLabLeft, contentLabRight, contentLabCenterY]];
    
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

@interface ADFilterSingleMenu ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@end
NSString *const adFilterMenuSingleViewCellReuseIdentifier = @"adFilterMenuSingleViewCellReuseIdentifier";
@implementation ADFilterSingleMenu
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[ADFilterMenuSingleViewCell class] forCellReuseIdentifier:adFilterMenuSingleViewCellReuseIdentifier];
    [self.contentView addSubview:_tableView];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *tableViewTop = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *tableViewLeft = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *tableViewRight = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *tableViewBottom = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[tableViewTop, tableViewLeft, tableViewRight, tableViewBottom]];
}

- (CGFloat)contentHeight {
    NSInteger count = 0;
    if ([self.dataSource respondsToSelector:@selector(filterMenu:numberItemInSection:)]) {
        count = [self.dataSource filterMenu:self numberItemInSection:0];
    }
    if (count > 6) {
        count = 6;
    }
    CGFloat height = count * kAdFilterFloat(44);
    return height;
}

- (void)selectedItemAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    NSIndexPath *indexPath = indexPaths.lastObject;
    [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)reloadData {
    [_tableView reloadData];
}

#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if ([self.dataSource respondsToSelector:@selector(filterMenu:numberItemInSection:)]) {
        count = [self.dataSource filterMenu:self numberItemInSection:section];
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAdFilterFloat(44);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ADFilterMenuSingleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adFilterMenuSingleViewCellReuseIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ADFilterMenuSingleViewCell *adCell = (ADFilterMenuSingleViewCell *)cell;
    NSString *content;
    if ([self.dataSource respondsToSelector:@selector(filterMenu:itemTitleAtIndexPath:)]) {
        content = [self.dataSource filterMenu:self itemTitleAtIndexPath:indexPath];
    }
    [adCell fillData:content];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(filterMenu:didSelectedItemAtIndexPath:)]) {
        [self.delegate filterMenu:self didSelectedItemAtIndexPath:indexPath];
    }
}

@end
