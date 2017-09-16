//
//  ADFilterCommon.h
//  ADFilter
//
//  Created by 马乾征 on 2017/9/13.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAdFilterHexColor(hexValue) [ADFilterCommon hexColor:hexValue]
#define kAdFilterFont(size) [ADFilterCommon systemFontOfSize:size andWeight:0]
#define kAdFilterFloat(value) [ADFilterCommon adaptationFloatValue:value]

@interface ADFilterCommon : NSObject
+ (UIColor *)hexColor:(NSInteger)hexValue;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (CGFloat)adaptationFloatValue:(CGFloat)value;
+ (UIFont *)systemFontOfSize:(CGFloat)size andWeight:(CGFloat)weight;
@end
