//
//  ADFilterMenuView.h
//  ADFilter
//
//  Created by 马乾征 on 2017/9/7.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ADFilterMenuDelegate;

@protocol ADFilterMenuDelegate;
@protocol ADFilterMenuDataSource;

@interface ADFilterMenu : UIView
@property (nonatomic, weak)id <ADFilterMenuDelegate> delegate;
@property (nonatomic, weak)id <ADFilterMenuDataSource> dataSource;
@property (nonatomic, strong, readonly)UIView *contentView;
@property (nonatomic, strong, readonly)UIView *backgroundView;
@property (nonatomic, assign)CGFloat contentHeight;
@property (nonatomic, copy)NSString *title;
- (void)appearWithFrame:(CGRect)frame animation:(BOOL)animation;
- (void)disappearWithAnimation:(BOOL)animation;
- (void)selectedItemAtIndexPaths:(NSArray <NSIndexPath *>*)indexPaths;
- (void)selectedItemAtSections:(NSArray <NSNumber *> *)sections;
- (void)reloadData;
@end

@protocol ADFilterMenuDelegate <NSObject>
@optional
- (void)filterMenu:(ADFilterMenu *)menu didSelectedItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)filterMenu:(ADFilterMenu *)menu didSelectedItemAtSection:(NSInteger)section;
- (void)filterMenuDidClickOnTheBlank:(ADFilterMenu *)menu;
@end
@protocol ADFilterMenuDataSource <NSObject>
@optional
- (NSString *)filterMenu:(ADFilterMenu *)menu itemTitleAtSection:(NSInteger)section;
- (NSString *)filterMenu:(ADFilterMenu *)menu itemTitleAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)filterMenuNumberOfSection:(ADFilterMenu *)menu;
- (NSInteger)filterMenu:(ADFilterMenu *)menu numberItemInSection:(NSInteger)section;
@end

