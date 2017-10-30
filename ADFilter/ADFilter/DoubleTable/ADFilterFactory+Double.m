//
//  ADFilterFactory+Double.m
//  ADFilter
//
//  Created by 马乾征 on 2017/9/15.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterFactory+Double.h"
#import "ADFilterDoubleMenu.h"

@implementation ADFilterFactory (Double)
+ (ADFilterMenu *)doubleMenuWithTitle:(NSString *)title {
    ADFilterDoubleMenu *menu = [[ADFilterDoubleMenu alloc] init];
    menu.title = title;
    return menu;
}
@end
