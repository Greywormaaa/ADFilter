//
//  ADFilterFactory+Single.m
//  ADFilter
//
//  Created by 马乾征 on 2017/9/13.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterFactory+Single.h"
#import "ADFilterSingleMenu.h"

@implementation ADFilterFactory (Single)
+ (ADFilterMenu *)singleMenuWithTitle:(NSString *)title {
    ADFilterSingleMenu *singleMenu = [[ADFilterSingleMenu alloc] init];
    singleMenu.title = title;
    return singleMenu;
}
@end
