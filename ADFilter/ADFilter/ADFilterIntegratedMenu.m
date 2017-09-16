//
//  ADFilterIntegratedMenu.m
//  ADFilter
//
//  Created by 马乾征 on 2017/9/15.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterIntegratedMenu.h"
#import "ADFilterCommon.h"
#import "ADFilterIntegratedMuneItem.h"
#import "ADFilterIntegratedReusableView.h"

@interface ADFilterIntegratedMenu ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *collectionView;
@end
@implementation ADFilterIntegratedMenu
NSString *const adFilterIntegratedMenuItemReuseIdentifier = @"adFilterIntegratedMenuItemReuseIdentifier";
NSString *const adFilterIntegratedMenuReuseViewReuseIdentifier = @"adFilterIntegratedMenuReuseViewReuseIdentifier";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[ADFilterIntegratedMuneItem class] forCellWithReuseIdentifier:adFilterIntegratedMenuItemReuseIdentifier];
    [_collectionView registerClass:[ADFilterIntegratedReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:adFilterIntegratedMenuReuseViewReuseIdentifier];
    [self.contentView addSubview:_collectionView];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *collectionTop = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *collectionLeft = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *collectionRight = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *collectionBottom = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[collectionTop, collectionLeft, collectionRight, collectionBottom]];
}

- (CGFloat)contentHeight {
    CGFloat height = 0;
    NSInteger section = 1;
    if ([self.dataSource respondsToSelector:@selector(filterMenuNumberOfSection:)]) {
        section = [self.dataSource filterMenuNumberOfSection:self];
    }
    for (int i = 0; i < section; i++) {
        NSInteger item = 0;
        if ([self.dataSource respondsToSelector:@selector(filterMenu:numberItemInSection:)]) {
            item = [self.dataSource filterMenu:self numberItemInSection:i];
        }
        if (item == 0) {
            continue;
        }
        NSInteger numberOfRow = item % 3 == 0 ? item / 3 : item / 3 + 1;
        height += numberOfRow * kAdFilterFloat(24 + 12) + kAdFilterFloat(32);
    }
    height += kAdFilterFloat(16);
    return height;
}

#pragma mark - collection delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger count = 1;
    if ([self.dataSource respondsToSelector:@selector(filterMenuNumberOfSection:)]) {
        count = [self.dataSource filterMenuNumberOfSection:self];
    }
    return count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = 0;
    if ([self.dataSource respondsToSelector:@selector(filterMenu:numberItemInSection:)]) {
        count = [self.dataSource filterMenu:self numberItemInSection:section];
    }
    return count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat spacing = kAdFilterFloat(24);
    return UIEdgeInsetsMake(12, spacing, 0, spacing);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(collectionView.frame);
    CGFloat itemWidth = (width - kAdFilterFloat(53 * 2 + 24 * 2)) / 3;
    CGFloat itemHeight = kAdFilterFloat(24);
    return CGSizeMake(itemWidth, itemHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, kAdFilterFloat(32));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kAdFilterFloat(12);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kAdFilterFloat(53);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ADFilterIntegratedReusableView *reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:adFilterIntegratedMenuReuseViewReuseIdentifier forIndexPath:indexPath];
        return reuseView;
    }
    return [[UICollectionReusableView alloc] init];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ADFilterIntegratedMuneItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:adFilterIntegratedMenuItemReuseIdentifier forIndexPath:indexPath];
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        ADFilterIntegratedReusableView *headerView = (ADFilterIntegratedReusableView *)view;
        NSString *content = nil;
        if ([self.dataSource respondsToSelector:@selector(filterMenu:itemTitleAtSection:)]) {
            content = [self.dataSource filterMenu:self itemTitleAtSection:indexPath.section];
        }
        [headerView fillData:content];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    ADFilterIntegratedMuneItem *item = (ADFilterIntegratedMuneItem *)cell;
    NSString *content = nil;
    if ([self.dataSource respondsToSelector:@selector(filterMenu:itemTitleAtIndexPath:)]) {
        content = [self.dataSource filterMenu:self itemTitleAtIndexPath:indexPath];
    }
    [item fillData:content];
}
@end
