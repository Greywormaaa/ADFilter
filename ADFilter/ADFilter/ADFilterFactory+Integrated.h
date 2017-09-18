//
//  ADFilterFactory+Integrated.h
//  ADFilter
//
//  Created by 马乾征 on 2017/9/15.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterFactory.h"
@class ADFilterMenu;
@interface ADFilterFactory (Integrated)
+ (ADFilterMenu *)integratedMenuWithTitle:(NSString *)title;
@end
