//
//  ADFilterDoubleMenu.m
//  ADFilter
//
//  Created by 马乾征 on 2017/9/15.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterDoubleMenu.h"
#import "ADFilterCommon.h"
#import "ADFilterDoubleMenuTableCell.h"

@interface ADFilterDoubleMenu ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *parentTableView;
@property (nonatomic, strong)UITableView *childTableView;
@end
@implementation ADFilterDoubleMenu

NSString *const adFilterDoubleMenuParentCellReuseIdentifier = @"adFilterDoubleMenuParentCellReuseIdentifier";
NSString *const adFilterDoubleMenuChildCellReuseIdentifier = @"adFilterDoubleMenuChildCellReuseIdentifier";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _parentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _parentTableView.backgroundColor = kAdFilterHexColor(0xf5f5f5);
    _parentTableView.showsVerticalScrollIndicator = NO;
    _parentTableView.delegate = self;
    _parentTableView.dataSource = self;
    _parentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_parentTableView registerClass:[ADFilterDoubleMenuParentCell class] forCellReuseIdentifier:adFilterDoubleMenuParentCellReuseIdentifier];
    [self.contentView addSubview:_parentTableView];
    
    _childTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _childTableView.backgroundColor = [UIColor clearColor];
    _childTableView.showsVerticalScrollIndicator = NO;
    _childTableView.delegate = self;
    _childTableView.dataSource = self;
    _childTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_childTableView registerClass:[ADFilterDoubleMenuChildCell class] forCellReuseIdentifier:adFilterDoubleMenuChildCellReuseIdentifier];
    [self.contentView addSubview:_childTableView];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    _parentTableView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *parentTableTop = [NSLayoutConstraint constraintWithItem:_parentTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *parentTableLeft = [NSLayoutConstraint constraintWithItem:_parentTableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *parentTableBottom = [NSLayoutConstraint constraintWithItem:_parentTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *parentTableRight = [NSLayoutConstraint constraintWithItem:_parentTableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[parentTableTop, parentTableLeft, parentTableRight, parentTableBottom]];
    
    _childTableView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *childTableTop = [NSLayoutConstraint constraintWithItem:_childTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *childTableLeft = [NSLayoutConstraint constraintWithItem:_childTableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *childTableRight = [NSLayoutConstraint constraintWithItem:_childTableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *childTableBottom = [NSLayoutConstraint constraintWithItem:_childTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[childTableTop, childTableLeft, childTableRight, childTableBottom]];
}

- (CGFloat)contentHeight {
    NSInteger parentCount = 6;
    CGFloat height = parentCount * kAdFilterFloat(44);
    return height;
}

- (void)selectedItemAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    NSIndexPath *indexPath = indexPaths.lastObject;
    NSInteger section = [self parentTableViewSelectedIndex];
    NSInteger row = indexPath.row;
    [_childTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)selectedItemAtSections:(NSArray <NSNumber *> *)sections {
    NSInteger section = [sections.lastObject integerValue];
    [_parentTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [_childTableView reloadData];
}

- (NSArray<NSIndexPath *> *)indexPathsForSelectedRows {
    NSMutableArray *rows = [NSMutableArray array];
    if (_parentTableView.indexPathsForSelectedRows.count) {
        NSInteger section = _parentTableView.indexPathsForSelectedRows.lastObject.row;
        for (NSIndexPath *childIndexPath in _childTableView.indexPathsForSelectedRows) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:childIndexPath.row inSection:section];
            [rows addObject:indexPath];
        }
    }
    return  rows.copy;
}

- (NSArray<NSNumber *> *)sectionsForSelected {
    NSMutableArray *sections = [NSMutableArray array];
    for (NSIndexPath *indexPath in _parentTableView.indexPathsForSelectedRows) {
        [sections addObject:@(indexPath.row)];
    }
    return sections.copy;
}

- (NSInteger)parentTableViewSelectedIndex {
    NSIndexPath *indexPath = [_parentTableView indexPathForSelectedRow];
    return indexPath.row;
}

- (void)reloadData {
    [_parentTableView reloadData];
    [_childTableView reloadData];
}

- (void)reloadChildData {
    [_childTableView reloadData];
}

#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _parentTableView) {
        NSInteger count = 0;
        if ([self.dataSource respondsToSelector:@selector(filterMenuNumberOfSection:)]) {
            count = [self.dataSource filterMenuNumberOfSection:self];
        }
        return count;
    }
    else {
        NSInteger count = 0;
        if ([self.dataSource respondsToSelector:@selector(filterMenu:numberItemInSection:)]) {
            NSInteger section = [self parentTableViewSelectedIndex];
            count = [self.dataSource filterMenu:self numberItemInSection:section];
        }
        return count;
    }
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _parentTableView) {
        ADFilterDoubleMenuParentCell *cell = [tableView dequeueReusableCellWithIdentifier:adFilterDoubleMenuParentCellReuseIdentifier forIndexPath:indexPath];
        return cell;
    }
    else {
        ADFilterDoubleMenuChildCell *cell = [tableView dequeueReusableCellWithIdentifier:adFilterDoubleMenuChildCellReuseIdentifier forIndexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _parentTableView) {
        NSString *content = nil;
        if ([self.dataSource respondsToSelector:@selector(filterMenu:itemTitleAtSection:)]) {
            content = [self.dataSource filterMenu:self itemTitleAtSection:indexPath.row];
        }
        ADFilterDoubleMenuParentCell *parentCell = (ADFilterDoubleMenuParentCell *)cell;
        [parentCell fillData:content];
    }else {
        NSString *content = nil;
        if ([self.dataSource respondsToSelector:@selector(filterMenu:itemTitleAtIndexPath:)]) {
            NSInteger section = [self parentTableViewSelectedIndex];
            NSInteger row = indexPath.row;
            content = [self.dataSource filterMenu:self itemTitleAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
        }
        ADFilterDoubleMenuChildCell *childCell = (ADFilterDoubleMenuChildCell *)cell;
        [childCell fillData:content];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _parentTableView) {
        [_childTableView reloadData];
        if ([self.delegate respondsToSelector:@selector(filterMenu:didSelectedItemAtSection:)]) {
            [self.delegate filterMenu:self didSelectedItemAtSection:indexPath.row];
        }
    }
    else {
        if ([self.delegate respondsToSelector:@selector(filterMenu:didSelectedItemAtIndexPath:)]) {
            NSInteger section = [self parentTableViewSelectedIndex];
            NSInteger row = indexPath.row;
            [self.delegate filterMenu:self didSelectedItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
        }
    }
}

@end
