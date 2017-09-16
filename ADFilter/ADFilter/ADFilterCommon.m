//
//  ADFilterCommon.m
//  ADFilter
//
//  Created by 马乾征 on 2017/9/13.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ADFilterCommon.h"

@implementation ADFilterCommon
+ (UIColor *)hexColor:(NSInteger)hexValue {
    CGFloat red = (CGFloat)((hexValue & 0xFF0000) >> 16) / 255.0;
    CGFloat green = (CGFloat)((hexValue & 0xFF00) >> 8) / 255.0;
    CGFloat blue = (CGFloat)((hexValue & 0xFF)) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (UIFont *)systemFontOfSize:(CGFloat)size andWeight:(CGFloat)weight {
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat scale = width / 375;
    return [UIFont systemFontOfSize:size * scale weight:weight];
}

+ (CGFloat)adaptationFloatValue:(CGFloat)value {
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat scale = width / 375;
    return value * scale;
}
@end
