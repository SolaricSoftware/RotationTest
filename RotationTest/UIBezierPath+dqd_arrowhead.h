//
//  UIBezierPath+dqd_arrowhead.h
//  ImageAnno
//
//  Created by Olan Hall on 8/26/15.
//  Copyright (c) 2015 Solaric Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (dqd_arrowhead)

+ (UIBezierPath *)dqd_bezierPathWithArrowFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint tailWidth:(CGFloat)tailWidth headWidth:(CGFloat)headWidth headLength:(CGFloat)headLength;

+ (void)dqd_getAxisAlignedArrowPoints:(CGPoint[7])points forLength:(CGFloat)length tailWidth:(CGFloat)tailWidth headWidth:(CGFloat)headWidth headLength:(CGFloat)headLength;

+ (CGAffineTransform)dqd_transformForStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint length:(CGFloat)length;

@end
