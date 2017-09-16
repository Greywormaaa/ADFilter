//
//  ADFilterFactory.m
//  ADFilter
//
//  Created by 马乾征 on 2017/9/13.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterFactory.h"
#import "ADFilterMenu.h"

@implementation ADFilterFactory
+ (ADFilterMenu *)menuWithTitle:(NSString *)title {
    ADFilterMenu *menu = [[ADFilterMenu alloc] init];
    menu.title = title;
    return menu;
}
@end
