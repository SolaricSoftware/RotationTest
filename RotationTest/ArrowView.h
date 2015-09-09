//
//  UIView+Arrow.h
//  ImageAnno
//
//  Created by Olan Hall on 8/26/15.
//  Copyright (c) 2015 Solaric Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
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
}

@property id <ArrowViewDelegate, DotButtonDelegate> delegate;
@property (nonatomic) UIColor *arrowColor;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) CGFloat tailWidth;
@property (nonatomic) CGFloat headWidth;
@property (nonatomic) CGFloat weight;
@property (nonatomic, setter=setIsSelected:) BOOL isSelected;

- (id) initWithFrame:(CGRect)frame withColor: (UIColor *) color withWeight: (CGFloat) weight withStartPoint: (CGPoint) startPoint withEndPoint: (CGPoint) endPoint;
- (void) updateStartPoint: (CGPoint) startPoint;
- (void) updateEndPoint: (CGPoint) endPoint;
- (void) updateColor: (UIColor *) color;
- (void) updateWeight: (CGFloat) weight;
- (void) setIsSelected: (BOOL) isSelected;

@end

@protocol ArrowViewDelegate <NSObject>

@optional
- (void) pathUpdated: (UIBezierPath *) path inView: (UIView *) view;

@end
