//
//  ADFilter.h
//  ADFilter
//
//  Created by 马乾征 on 2017/8/30.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ADFilterMenu;
@protocol ADFilterDelegate;
@protocol ADFilterDataSource;

@interface ADFilter : UIView
@property (nonatomic, copy)NSString *itemClassName; //继承自ADCollectionItem, 默认为ADFilterUnitTitleItem
@property (nonatomic, strong, readonly)NSArray *menuArray;
@property (nonatomic, weak)id <ADFilterDelegate> delegate;
@property (nonatomic, weak)id <ADFilterDataSource> dataSource;
- (void)addMenu:(ADFilterMenu *)menu;
- (void)setMenus:(NSArray <ADFilterMenu *>*)menus;
- (ADFilterMenu *)menuWithZone:(NSInteger)zone;
- (void)setTitle:(NSString *)title zone:(NSInteger)zone;
- (void)selectedItemAtIndexPaths:(NSArray <NSIndexPath *>*)indexPaths zone:(NSInteger)zone;
- (void)selectedItemAtSections:(NSArray <NSNumber *> *)sections zone:(NSInteger)zone;
- (void)showMenuViewAtZone:(NSInteger)zone;
- (void)dismissMenuViewAtZone:(NSInteger)zone animation:(BOOL)animation;
- (void)dismissCurrentMneu;
- (void)reloadData;
@end

@protocol ADFilterDelegate <NSObject>
@optional
- (void)filter:(ADFilter *)filter didSelectedItemAtIndexPath:(NSIndexPath *)indexPath zone:(NSInteger)zone;
- (void)filter:(ADFilter *)filter didSelectedItemAtSection:(NSInteger)section zone:(NSInteger)zone;
- (void)filter:(ADFilter *)filter didSelectedItemAtZone:(NSInteger)zone;
@end

@protocol ADFilterDataSource <NSObject>
@optional
- (NSString *)filter:(ADFilter *)filter itemTitleAtSection:(NSInteger)section zone:(NSInteger)zone;
- (NSString *)filter:(ADFilter *)filter itemTitleAtIndexPath:(NSIndexPath *)indexPath zone:(NSInteger)zone;
- (NSInteger)filter:(ADFilter *)filter numberOfSectionInZone:(NSInteger)zone;
- (NSInteger)filter:(ADFilter *)filter numberOfItemInSection:(NSInteger)section zone:(NSInteger)zone;
@end

