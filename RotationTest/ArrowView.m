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

- (id) initWithFrame:(CGRect)frame withColor: (UIColor *) color withWeight: (CGFloat) weight {
    if (self = [super initWithFrame:frame]) {
        _arrowColor = color;
        _weight = weight;
        
        _dotButtonSize = 25;
        _dotButtonIndex = kDotButtonSecond;
        _startPoint = CGPointMake(0, 0);
        _endPoint = CGPointMake(frame.size.width, frame.size.height);
        
        self.userInteractionEnabled = YES;
        
        self.layer.borderColor = [UIColor brownColor].CGColor;
        self.layer.borderWidth = 1;
        
        self.backgroundColor = [UIColor clearColor];
        
        [_startDotButton removeFromSuperview];
        CGRect startDotFrame = CGRectMake(-5, -2.5, _dotButtonSize, _dotButtonSize);
        _startDotButton = [[DotButton alloc] initWithFrame: startDotFrame DotSize:_dotButtonSize Color:[UIColor greenColor] InnerColor:[UIColor whiteColor]];
        _startDotButton.delegate = self;
        _startDotButton.backgroundColor = [UIColor clearColor];
        //[self addSubview:_startDotButton];
        [self bringSubviewToFront:_startDotButton];
        
        [_endDotButton removeFromSuperview];
        CGRect endDotFrame = CGRectMake(path.bounds.size.width - (_dotButtonSize - 2.5), -2.5, _dotButtonSize, _dotButtonSize);
        _endDotButton = [[DotButton alloc] initWithFrame: endDotFrame DotSize:_dotButtonSize Color:[UIColor greenColor] InnerColor:[UIColor whiteColor]];
        _endDotButton.delegate = self;
        _endDotButton.backgroundColor = [UIColor clearColor];
        //[self addSubview:_endDotButton];
        [self bringSubviewToFront:_endDotButton];
        
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
        [self addGestureRecognizer:pan];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
        [self addGestureRecognizer:tap];
    }

    return self;
}

- (void) panHandler: (UIPanGestureRecognizer *) sender {
    if (_dotSelected) {
        if (sender.state == UIGestureRecognizerStateBegan) {
            _initialAngle = pToA(sender, self, _dotButtonIndex);
            
            if (_dotButtonIndex == kDotButtonFirst) {
                [self setPosition:1];
            } else {
                [self setPosition:0];
            }
            
        } else if (sender.state == UIGestureRecognizerStateChanged) {
            CGFloat ang = pToA(sender, self, _dotButtonIndex);
            ang -= _initialAngle;
            self.transform = CGAffineTransformRotate(self.transform, ang);
            
            if (_dotButtonIndex == kDotButtonSecond) {
                CGPoint loc = [sender locationInView:sender.view];
                CGFloat diff = (loc.x - self.bounds.size.width);
                
                NSLog(@"\n\n \n Position: 0 \n diff: %f \n bounds: %@ \n\n", diff, NSStringFromCGRect(self.bounds));
                
                self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width + diff, self.bounds.size.height);
                _endPoint = CGPointMake(self.bounds.size.width, self.bounds.size.height);
                [self setNeedsDisplay];
            } else {
                CGPoint loc = [sender locationInView:sender.view];
                CGFloat diff = (loc.x - self.bounds.origin.x);

                NSLog(@"\n\n \n Position: 1 \n diff: %f \n bounds: %@ \n\n", diff, NSStringFromCGRect(self.bounds));

                
                self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width - diff, self.bounds.size.height);
                

                _endPoint = CGPointMake(self.bounds.size.width, self.bounds.size.height);
                [self setNeedsDisplay];
            }
        } else if (sender.state == UIGestureRecognizerStateEnded) {
            _dotSelected = NO;
        }
    } else {
        if (sender.numberOfTouches > 0) {
            CGPoint translation = [sender translationInView:sender.view.superview];
            sender.view.center = CGPointMake(sender.view.center.x + translation.x, sender.view.center.y + translation.y);
            [sender setTranslation:CGPointMake(0, 0) inView:sender.view];
        }
    }
}

- (void) tapHandler: (UITapGestureRecognizer *) sender {
    if ([UIView alphaFromPoint:[sender locationInView:sender.view] withLayer:self.layer] > 0) {
        [self setIsSelected:YES];
        
        if ([_delegate respondsToSelector:@selector(arrowTouched:inView:)]) {
            [_delegate arrowTouched:YES inView:self];
        }
    } else {
        [self setIsSelected:NO];
        if ([_delegate respondsToSelector:@selector(arrowTouched:inView:)]) {
            [_delegate arrowTouched:NO inView:self];
        }
    }
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [_arrowLayer removeFromSuperlayer];
    [_bottomButtonLayer removeFromSuperlayer];
    [_topButtonLayer removeFromSuperlayer];
    
    _tailWidth = 6 + _weight;
    _headWidth = 25 + _weight;
    headLength = 40;
    
    _arrowLayer = [CAShapeLayer layer];
    _arrowLayer.position = CGPointMake(0, self.bounds.size.height / 2);

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
    
    [self showDots];
}

- (void) dotButtonTouchBegan: (DotButton *) button {
    _dotSelected = YES;
    
    _dotButtonIndex = kDotButtonFirst;
    if (button == _endDotButton) {
        _dotButtonIndex = kDotButtonSecond;
    }
    
    if ([_delegate respondsToSelector:@selector(dotTouchBegan:inView:forIndex:)]) {
        [_delegate dotTouchBegan:button inView:self forIndex:_dotButtonIndex];
    }
}

- (void) dotButtonTouchEnded: (DotButton *) button {
    _dotSelected = NO;
    
    _dotButtonIndex = kDotButtonFirst;
    if (button == _endDotButton) {
        _dotButtonIndex = kDotButtonSecond;
    }
    
    if ([_delegate respondsToSelector:@selector(dotTouchEnded:inView:forIndex:)]) {
        [_delegate dotTouchEnded:button inView:self forIndex:_dotButtonIndex];
    }
}

- (void) showDots {
    if (_isSelected) {
        CGRect startDotFrame = CGRectMake(-5, 0, _dotButtonSize, _dotButtonSize);
        _startDotButton.frame = startDotFrame;
        [self addSubview:_startDotButton];
        [self bringSubviewToFront:_startDotButton];
        
        CGRect endDotFrame = CGRectMake(path.bounds.size.width - (_dotButtonSize - 2.5), 0, _dotButtonSize, _dotButtonSize);
        _endDotButton.frame = endDotFrame;
        [self addSubview:_endDotButton];
        [self bringSubviewToFront:_endDotButton];
    } else {
        [_startDotButton removeFromSuperview];
        [_endDotButton removeFromSuperview];
    }
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

- (void) setPosition: (CGFloat) anchorPointX {
    CGPoint layerLoc;
    
    if (anchorPointX == 0) {
        layerLoc = CGPointMake(self.layer.bounds.origin.x, self.layer.bounds.origin.y + (self.layer.bounds.size.height / 2));
    } else {
        layerLoc = CGPointMake(self.layer.bounds.origin.x + self.layer.bounds.size.width, self.layer.bounds.origin.y + (self.layer.bounds.size.height / 2));
    }
    
    CGPoint superLoc = [self convertPoint:layerLoc toView:self.superview];
    
    self.layer.anchorPoint = CGPointMake(anchorPointX, 0.5);
    self.layer.position = superLoc;
}

static CGFloat pToA (UIGestureRecognizer * sender, UIView* view, DotButtonIndex index) {
    CGPoint loc = [sender locationInView: sender.view];
    CGPoint c;
    if (index == kDotButtonFirst) {
        c = CGPointMake(CGRectGetMaxX(view.bounds), CGRectGetMaxY(view.bounds));
    } else {
        c = CGPointMake(CGRectGetMinX(view.bounds), CGRectGetMinY(view.bounds));
    }
    return atan2(c.y - loc.y, c.x - loc.x);
}

@end
