//
//  ADFilterFactory+Single.h
//  ADFilter
//
//  Created by 马乾征 on 2017/9/13.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterFactory.h"
@class ADFilterSingleMenu;
@interface ADFilterFactory (Single)
+ (ADFilterSingleMenu *)singleMenuWithTitle:(NSString *)title;
@end
