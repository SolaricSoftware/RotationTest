//
//  UIView+Color.m
//  ImageAnno
//
//  Created by Olan Hall on 9/4/15.
//  Copyright (c) 2015 Solaric Software LLC. All rights reserved.
//

#import "UIView+Color.h"

@implementation UIView (Color)

+ (CGFloat) alphaFromPoint: (CGPoint) point withLayer: (CALayer *) layer {
    UInt8 pixel[4] = {0,0,0,0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo alphaInfo = (CGBitmapInfo)kCGImageAlphaPremultipliedLast;
    CGContextRef context = CGBitmapContextCreate(&pixel, 1, 1, 8, 4, colorSpace, alphaInfo);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [layer renderInContext:context];
    CGFloat floatAlpha = pixel[3];
    return floatAlpha;
}

@end
