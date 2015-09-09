//
//  UIView+Arrow.m
//  ImageAnno
//
//  Created by Olan Hall on 8/26/15.
//  Copyright (c) 2015 Solaric Software LLC. All rights reserved.
//

#import "ArrowView.h"


@implementation ArrowView
{
    CGFloat headLength;
    UIBezierPath *path;
}

- (id) initWithFrame:(CGRect)frame withColor: (UIColor *) color withWeight: (CGFloat) weight withStartPoint: (CGPoint) startPoint withEndPoint: (CGPoint) endPoint {
    if (self = [super initWithFrame:frame]) {
        _arrowColor = color;
        _weight = weight;
        _startPoint = startPoint;
        _endPoint = endPoint;
        _dotButtonSize = 25;
        
        self.userInteractionEnabled = YES;
        
        self.layer.borderColor = [UIColor brownColor].CGColor;
        self.layer.borderWidth = 1;
        
        self.backgroundColor = [UIColor clearColor];
        
        [_startDotButton removeFromSuperview];
        CGRect startDotFrame = CGRectMake(-5, -2.5, _dotButtonSize, _dotButtonSize);
        _startDotButton = [[DotButton alloc] initWithFrame: startDotFrame DotSize:_dotButtonSize Color:[UIColor greenColor] InnerColor:[UIColor whiteColor]];
        _startDotButton.backgroundColor = [UIColor clearColor];
        [self addSubview:_startDotButton];
        [self bringSubviewToFront:_startDotButton];
        
        [_endDotButton removeFromSuperview];
        CGRect endDotFrame = CGRectMake(path.bounds.size.width - (_dotButtonSize - 2.5), -2.5, _dotButtonSize, _dotButtonSize);
        _endDotButton = [[DotButton alloc] initWithFrame: endDotFrame DotSize:_dotButtonSize Color:[UIColor greenColor] InnerColor:[UIColor whiteColor]];
        _endDotButton.backgroundColor = [UIColor clearColor];
        [self addSubview:_endDotButton];
        [self bringSubviewToFront:_endDotButton];
    }

    return self;
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [_arrowLayer removeFromSuperlayer];
    [_bottomButtonLayer removeFromSuperlayer];
    [_topButtonLayer removeFromSuperlayer];
    
    _tailWidth = 6 + _weight;
    _headWidth = 25 + _weight;
    headLength = 40;

    CGFloat width = _endPoint.x - _startPoint.x;
    CGFloat height = _endPoint.y - _startPoint.y;
    
    _offset = 0;
    if (ABS(width) < _offset) {
        width = width > 0 ? _offset : -_offset;
    }
    
    if (ABS(height) < _offset) {
        height = height > 0 ? _offset : -_offset;
    }

    _arrowLayer = [CAShapeLayer layer];
    _arrowLayer.position = CGPointMake(0, self.frame.size.height / 2);
    //_arrowLayer.anchorPoint = CGPointMake(0, 0);

    path = [UIBezierPath dqd_bezierPathWithArrowFromPoint:(CGPoint)_startPoint
                                                  toPoint:(CGPoint)_endPoint
                                                tailWidth:(CGFloat)_tailWidth
                                                headWidth:(CGFloat)_headWidth
                                               headLength:(CGFloat)headLength];
    path.lineWidth = _weight;
    
    if ([_delegate respondsToSelector:@selector(pathUpdated:inView:)]) {
        [_delegate pathUpdated:path inView:self];
    }
    
    _arrowLayer.path = path.CGPath;
    _arrowLayer.fillColor = _arrowColor.CGColor;
    
    if (!_isSelected) {
        _arrowLayer.strokeColor = _arrowColor.CGColor;
    } else {
        if (_arrowColor != [UIColor blackColor]) {
            _arrowLayer.strokeColor = [UIColor blackColor].CGColor;
        } else {
            _arrowLayer.strokeColor = [UIColor whiteColor].CGColor;
        }
    }
    
    _arrowLayer.borderColor = [UIColor blueColor].CGColor;
    _arrowLayer.borderWidth = 1;
    
    [self.layer addSublayer:_arrowLayer];
    
    [self createDots];
}

- (void) createDots {
//    [_startDotButton removeFromSuperview];
    CGRect startDotFrame = CGRectMake(-5, -2.5, _dotButtonSize, _dotButtonSize);
    _startDotButton.frame = startDotFrame;
//    _startDotButton = [[DotButton alloc] initWithFrame: startDotFrame DotSize:_dotButtonSize Color:[UIColor greenColor] InnerColor:[UIColor whiteColor]];
//    _startDotButton.backgroundColor = [UIColor clearColor];
    _startDotButton.delegate = _delegate;
//    [self addSubview:_startDotButton];
    [self bringSubviewToFront:_startDotButton];
    
//    [_endDotButton removeFromSuperview];
    CGRect endDotFrame = CGRectMake(path.bounds.size.width - (_dotButtonSize - 2.5), -2.5, _dotButtonSize, _dotButtonSize);
    _endDotButton.frame = endDotFrame;
//    _endDotButton = [[DotButton alloc] initWithFrame: endDotFrame DotSize:_dotButtonSize Color:[UIColor greenColor] InnerColor:[UIColor whiteColor]];
//    _endDotButton.backgroundColor = [UIColor clearColor];
    _endDotButton.delegate = _delegate;
//    [self addSubview:_endDotButton];
    [self bringSubviewToFront:_endDotButton];

    self.frame = CGRectMake(0, 0, path.bounds.size.width, path.bounds.size.height);
}

- (void) setIsSelected: (BOOL) isSelected {
    _isSelected = isSelected;
    [self setNeedsDisplay];
}

- (void) updateStartPoint: (CGPoint) startPoint {
    _startPoint = startPoint;
    [self setNeedsDisplay];
}

- (void) updateEndPoint: (CGPoint) endPoint {
    _endPoint = endPoint;
    [self setNeedsDisplay];
}

- (void) updateColor: (UIColor *) color {
    _arrowColor = color;
    [self setNeedsDisplay];
}

- (void) updateWeight: (CGFloat) weight {
    _weight = weight;
    [self setNeedsDisplay];
}

@end
