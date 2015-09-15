//
//  UIView+Arrow.h
//  ImageAnno
//
//  Created by Olan Hall on 8/26/15.
//  Copyright (c) 2015 Solaric Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "UIBezierPath+dqd_arrowhead.h"
#import "UIView+Color.h"
#import "DotButton.h"

@protocol ArrowViewDelegate;

@interface ArrowView : UIView <DotButtonDelegate> {
    CAShapeLayer *_arrowLayer;
    CAShapeLayer *_bottomButtonLayer;
    CAShapeLayer *_topButtonLayer;
    CGFloat _offset;
    DotButton *_startDotButton;
    DotButton *_endDotButton;
    CGFloat _dotButtonSize;
    CGFloat _panViewSize;
    UIView *_panView;
    CGRect _lastFrame;
    CGFloat _initialAngle;
    BOOL _dotSelected;
}

@property id <ArrowViewDelegate> delegate;
@property (nonatomic) UIColor *arrowColor;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) CGFloat tailWidth;
@property (nonatomic) CGFloat headWidth;
@property (nonatomic) CGFloat weight;
@property (nonatomic, setter=setIsSelected:) BOOL isSelected;
@property (nonatomic) DotButtonIndex dotButtonIndex;

//- (id) initWithFrame:(CGRect)frame withColor: (UIColor *) color withWeight: (CGFloat) weight withStartPoint: (CGPoint) startPoint withEndPoint: (CGPoint) endPoint;
- (id) initWithFrame:(CGRect)frame withColor: (UIColor *) color withWeight: (CGFloat) weight;
- (void) drawArrow: (CGPoint) startPoint to: (CGPoint) endPoint;
- (void) updateColor: (UIColor *) color;
- (void) updateWeight: (CGFloat) weight;
- (void) setIsSelected: (BOOL) isSelected;
- (void) changeOrientation: (UIInterfaceOrientation) newOrientation;

@end

@protocol ArrowViewDelegate <NSObject>

@optional
- (void) pathUpdated: (UIBezierPath *) path inView: (UIView *) view;
- (void) dotTouchBegan: (DotButton *) button inView: (ArrowView *) view forIndex:(DotButtonIndex)index;
- (void) dotTouchEnded: (DotButton *) button inView: (ArrowView *) view forIndex:(DotButtonIndex)index;
- (void) arrowTouched: (BOOL) selected inView: (ArrowView *) view;

@end
