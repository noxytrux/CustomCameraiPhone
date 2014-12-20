//
//  UIImage+Utilities.m
//  CustomCameraiPhone
//
//  Created by Marcin Pędzimąż on 20.12.2014.
//  Copyright (c) 2014 Marcin Pedzimaz. All rights reserved.
//

#import "UIImage+Utilities.h"

@implementation UIImage (Utilities)

+ (UIImage *)imageWithRadius:(CGFloat)radius
                       color:(UIColor *)fillColor
{
    CGFloat size = 2.0*radius;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextSetLineWidth(context, 0.0);
    CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, CGRectMake(0.0,
                                                  0.0,
                                                  size,
                                                  size));
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
