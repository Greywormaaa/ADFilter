//
//  ADFilterFactory+Integrated.m
//  ADFilter
//
//  Created by 马乾征 on 2017/9/15.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterFactory+Integrated.h"
#import "ADFilterIntegratedMenu.h"

@implementation ADFilterFactory (Integrated)
+ (ADFilterIntegratedMenu *)integratedMenuWithTitle:(NSString *)title {
    ADFilterIntegratedMenu *menu = [[ADFilterIntegratedMenu alloc] init];
    menu.title = title;
    return menu;
}
@end
