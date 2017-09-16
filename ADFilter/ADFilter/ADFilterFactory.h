//
//  ADFilterFactory.h
//  ADFilter
//
//  Created by 马乾征 on 2017/9/13.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ADFilterMenu;

@interface ADFilterFactory : NSObject
+ (ADFilterMenu *)menuWithTitle:(NSString *)title;
@end
