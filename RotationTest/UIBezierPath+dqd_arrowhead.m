//
//  UIBezierPath+dqd_arrowhead.m
//  ImageAnno
//
//  Created by Olan Hall on 8/26/15.
//  Copyright (c) 2015 Solaric Software LLC. All rights reserved.
//

#import "UIBezierPath+dqd_arrowhead.h"

#define kArrowPointCount 7

@implementation UIBezierPath (dqd_arrowhead)

+ (UIBezierPath *)dqd_bezierPathWithArrowFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint tailWidth:(CGFloat)tailWidth headWidth:(CGFloat)headWidth headLength:(CGFloat)headLength {
    CGFloat x = endPoint.x - startPoint.x;
    CGFloat y = endPoint.y - startPoint.y;
    CGFloat length = hypotf(x, y);
    
//    NSLog(@"\n\nstartPoint: %@ \nendPoint: %@ \nx: %f \ny: %f \nlength: %f \n\n", NSStringFromCGPoint(startPoint), NSStringFromCGPoint(endPoint), x, y, length);

    CGPoint points[kArrowPointCount];
    [self dqd_getAxisAlignedArrowPoints:points forLength:length tailWidth:tailWidth headWidth:headWidth headLength:headLength];
    //CGAffineTransform transform = [self dqd_transformForStartPoint:startPoint endPoint:endPoint length:length];
    CGMutablePathRef cgPath = CGPathCreateMutable();
    CGPathAddLines(cgPath, nil, points, sizeof points / sizeof *points);
    CGPathCloseSubpath(cgPath);
    UIBezierPath *uiPath = [UIBezierPath bezierPathWithCGPath:cgPath];
    CGPathRelease(cgPath);
    
    return uiPath;
}

+ (void)dqd_getAxisAlignedArrowPoints:(CGPoint[kArrowPointCount])points
                            forLength:(CGFloat)length
                            tailWidth:(CGFloat)tailWidth
                            headWidth:(CGFloat)headWidth
                           headLength:(CGFloat)headLength {
    CGFloat tailLength = length - headLength;
    points[0] = CGPointMake(0, tailWidth / 2);
    points[1] = CGPointMake(tailLength, tailWidth / 2);
    points[2] = CGPointMake(tailLength, headWidth / 2);
    points[3] = CGPointMake(length, 0);
    points[4] = CGPointMake(tailLength, -headWidth / 2);
    points[5] = CGPointMake(tailLength, -tailWidth / 2);
    points[6] = CGPointMake(0, -tailWidth / 2);
}

+ (CGAffineTransform)dqd_transformForStartPoint:(CGPoint)startPoint
                                       endPoint:(CGPoint)endPoint
                                         length:(CGFloat)length {
    CGFloat cosine = (endPoint.x - startPoint.x) / length;
    CGFloat sine = (endPoint.y - startPoint.y) / length;
    return (CGAffineTransform){ cosine, sine, -sine, cosine, startPoint.x, startPoint.y };
}

@end
