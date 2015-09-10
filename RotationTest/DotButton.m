//
//  DotButton.m
//  ImageAnno
//
//  Created by Olan Hall on 9/2/15.
//  Copyright (c) 2015 Solaric Software LLC. All rights reserved.
//

#import "DotButton.h"

@implementation DotButton

- (id) initWithFrame: (CGRect) frame DotSize: (CGFloat) dotSize Color: (UIColor *) color InnerColor: (UIColor *) innerColor {
    if (self = [super initWithFrame:frame]) {
        _dotSize = dotSize;
        _color = color;
        _innerColor = innerColor;
    }
    
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(dotButtonTouchBegan:)]) {
        [_delegate dotButtonTouchBegan:self];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(dotButtonTouchEnded:)]) {
        [_delegate dotButtonTouchEnded:self];
    }
}

- (void) drawRect:(CGRect)rect {
    _dotLayer = [CAShapeLayer layer];
    _dotLayer.bounds = CGRectMake(-(_dotSize /2) , -(_dotSize / 2), _dotSize, _dotSize);
    _dotLayer.position = CGPointMake(0, 0);
    _dotLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _dotSize, _dotSize) cornerRadius:_dotSize - 1].CGPath;
    _dotLayer.fillColor = _color.CGColor;
    [self.layer addSublayer:_dotLayer];
    
    CGFloat smallDotSize = _dotSize * 0.75;
    _dotLayer = [CAShapeLayer layer];
    _dotLayer.bounds = CGRectMake(-(_dotSize/2) , -(_dotSize/2), smallDotSize, smallDotSize);
    _dotLayer.position = CGPointMake(0, 0);
    _dotLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, smallDotSize, smallDotSize) cornerRadius:smallDotSize - 1].CGPath;
    _dotLayer.fillColor = _innerColor.CGColor;
    [self.layer addSublayer:_dotLayer];
}

@end
