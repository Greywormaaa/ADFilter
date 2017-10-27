//
//  ADFilter.m
//  ADFilter
//
//  Created by 马乾征 on 2017/8/30.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilter.h"
#import "ADFilterCollectionItem.h"
#import "ADFilterMenu.h"
#import "ADFilterCommon.h"

@interface ADFilter ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    ADFilterMenuDelegate,
    ADFilterMenuDataSource
>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, assign)NSInteger selectedIndex;
@property (nonatomic, strong)UIImageView *bottomLine;
@end

@implementation ADFilter
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    _menuArray = [NSMutableArray array];
    _selectedIndex = NSNotFound;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
    
    _bottomLine = [[UIImageView alloc] init];
    _bottomLine.backgroundColor = kAdFilterHexColor(0xdddddd);
    [self addSubview:_bottomLine];
    
    self.itemClassName = NSStringFromClass([ADFilterUnitTitleItem class]);
    
    [self makeConstraints];
}

- (void)makeConstraints {
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *collectionTop = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *collectionLeft = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *collectionRight = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *collectionBottom = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self addConstraints:@[collectionTop, collectionLeft, collectionRight, collectionBottom]];
    
    _bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *bottomLineBottom = [NSLayoutConstraint constraintWithItem:_bottomLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomLineLeft = [NSLayoutConstraint constraintWithItem:_bottomLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomLineRight = [NSLayoutConstraint constraintWithItem:_bottomLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomLineHeight = [NSLayoutConstraint constraintWithItem:_bottomLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil  attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.5];
    [self addConstraints:@[bottomLineLeft, bottomLineRight, bottomLineBottom]];
    [_bottomLine addConstraint:bottomLineHeight];
}

- (void)setItemClassName:(NSString *)itemClassName {
    _itemClassName = itemClassName;
    Class itemClass = NSClassFromString(itemClassName);
    NSString *reuseIdentifier = [itemClassName stringByAppendingString:@"reuseIdentifier"];
    [_collectionView registerClass:itemClass forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)addMenu:(ADFilterMenu *)menu {
    NSMutableArray *mutableMenuArray = _menuArray.mutableCopy;
    menu.delegate = self;
    menu.dataSource = self;
    [mutableMenuArray addObject:menu];
    _menuArray = mutableMenuArray.copy;
}

- (void)setMenus:(NSArray<ADFilterMenu *> *)menus {
    _menuArray = [NSArray array];
    for (ADFilterMenu *menu in menus) {
        [self addMenu:menu];
    }
}

- (ADFilterMenu *)menuWithZone:(NSInteger)zone {
    ADFilterMenu *menu = _menuArray[zone];
    return menu;
}

- (void)setTitle:(NSString *)title zone:(NSInteger)zone {
    ADFilterMenu *menu = _menuArray[zone];
    menu.title = title;
    [self reloadData];
}

- (void)selectedItemAtSections:(NSArray <NSNumber *> *)sections zone:(NSInteger)zone {
    ADFilterMenu *menu = _menuArray[zone];
    [menu selectedItemAtSections:sections];
}

- (void)selectedItemAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths zone:(NSInteger)zone {
    ADFilterMenu *menu = _menuArray[zone];
    [menu selectedItemAtIndexPaths:indexPaths];
}

- (void)reloadData {
    [_collectionView reloadData];
    if (_selectedIndex != NSNotFound) {
        [self dismissCurrentMneu:NO];
    }
}

- (void)reloadDataZone:(NSInteger)zone {
    [_collectionView reloadData];
    if (_selectedIndex != NSNotFound) {
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
    ADFilterMenu *menu = _menuArray[zone];
    [menu reloadData];
}

#pragma mark - collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _menuArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = _menuArray.count;
    CGFloat width = CGRectGetWidth(collectionView.frame);
    CGFloat height = CGRectGetHeight(collectionView.frame);
    CGSize size = CGSizeMake(width / count, height);
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = [_itemClassName stringByAppendingString:@"reuseIdentifier"];
    ADFilterCollectionItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    ADFilterMenu *menu = _menuArray[indexPath.row];
    NSString *title = menu.title;
    ADFilterCollectionItem *item = (ADFilterCollectionItem *)cell;
    if ([item respondsToSelector:@selector(fillContent:)]) {
        [item fillContent:title];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedIndex == indexPath.row) {
        [self dismissMenuViewAtZone:indexPath.row animation:NO];
        _selectedIndex = NSNotFound;
        [_collectionView deselectItemAtIndexPath:indexPath animated:NO];
        return;
    }
    [self showMenuViewAtZone:indexPath.row];
    _selectedIndex = indexPath.row;
    
    if ([self.delegate respondsToSelector:@selector(filter:didSelectedItemAtZone:)]) {
        [self.delegate filter:self didSelectedItemAtZone:indexPath.row];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissMenuViewAtZone:indexPath.row animation:YES];
}

- (void)showMenuViewAtZone:(NSInteger)zone {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect selfFrameInWindow = [self convertRect:self.bounds toView:keyWindow];
    CGFloat x = CGRectGetMinX(selfFrameInWindow);
    CGFloat y = CGRectGetMinY(selfFrameInWindow) + CGRectGetHeight(selfFrameInWindow);
    CGFloat width = CGRectGetWidth(selfFrameInWindow);
    CGFloat height = CGRectGetHeight(keyWindow.frame) - y;
    CGRect menuViewFrame = CGRectMake(x, y, width, height);
    ADFilterMenu *menu = _menuArray[zone];
    [menu appearWithFrame:menuViewFrame animation:YES];
}

- (void)dismissMenuViewAtZone:(NSInteger)zone animation:(BOOL)animation {
    ADFilterMenu *menu = _menuArray[zone];
    [menu disappearWithAnimation:animation];
    _selectedIndex = NSNotFound;
    [_collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForRow:zone inSection:0] animated:YES];
}

- (void)dismissCurrentMneu:(BOOL)animation {
    if (_selectedIndex == NSNotFound) {
        return;
    }
    [self dismissMenuViewAtZone:_selectedIndex animation:animation];
}

- (void)menuViewTouchTheClearing {
    NSIndexPath *indexPath = [_collectionView indexPathsForSelectedItems].lastObject;
    [_collectionView deselectItemAtIndexPath:indexPath animated:NO];
    _selectedIndex = NSNotFound;
}

#pragma mark - menu delegate
- (void)filterMenu:(ADFilterMenu *)menu didSelectedItemAtSection:(NSInteger)section {
    NSInteger index = [_menuArray indexOfObject:menu];
    if ([self.delegate respondsToSelector:@selector(filter:didSelectedItemAtSection:zone:)]) {
        [self.delegate filter:self didSelectedItemAtSection:section zone:index];
    }
}

- (void)filterMenu:(ADFilterMenu *)menu didSelectedItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [_menuArray indexOfObject:menu];
    if ([self.delegate respondsToSelector:@selector(filter:didSelectedItemAtIndexPath:zone:)]) {
        [self.delegate filter:self didSelectedItemAtIndexPath:indexPath zone:index];
    }
}

- (void)filterMenuDidClickOnTheBlank:(ADFilterMenu *)menu {
    NSInteger index = [_menuArray indexOfObject:menu];
    [_collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES];
    _selectedIndex = NSNotFound;
}
#pragma mark - menu data source
- (NSInteger)filterMenuNumberOfSection:(ADFilterMenu *)menu {
    NSInteger index = [_menuArray indexOfObject:menu];
    NSInteger count = 1;
    if ([self.dataSource respondsToSelector:@selector(filter:numberOfSectionInZone:)]) {
        count = [self.dataSource filter:self numberOfSectionInZone:index];
    }
    return count;
}

- (NSInteger)filterMenu:(ADFilterMenu *)menu numberItemInSection:(NSInteger)section {
    NSInteger index = [_menuArray indexOfObject:menu];
    NSInteger count = 0;
    if ([self.dataSource respondsToSelector:@selector(filter:numberOfItemInSection:zone:)]) {
        count = [self.dataSource filter:self numberOfItemInSection:section zone:index];
    }
    return count;
}

- (NSString *)filterMenu:(ADFilterMenu *)menu itemTitleAtSection:(NSInteger)section {
    NSInteger index = [_menuArray indexOfObject:menu];
    NSString *content = nil;
    if ([self.dataSource respondsToSelector:@selector(filter:itemTitleAtSection:zone:)]) {
        content = [self.dataSource filter:self itemTitleAtSection:section zone:index];
    }
    return content;
}

- (NSString *)filterMenu:(ADFilterMenu *)menu itemTitleAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [_menuArray indexOfObject:menu];
    NSString *content;
    if ([self.dataSource respondsToSelector:@selector(filter:itemTitleAtIndexPath:zone:)]) {
        content = [self.dataSource filter:self itemTitleAtIndexPath:indexPath zone:index];
    }
    return content;
}
@end
