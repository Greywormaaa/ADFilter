//
//  ADCollectionItem.h
//  ADFilter
//
//  Created by 马乾征 on 2017/8/30.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    ad base collection item
 */
@interface ADFilterCollectionItem : UICollectionViewCell
- (void)fillContent:(NSString *)content;
@end

/**
    filter unit item
 */
@interface ADFilterUnitTitleItem : ADFilterCollectionItem

@end
