//
//  DrawPadView.m
//  ImageAnno
//
//  Created by Olan Hall on 9/1/15.
//  Copyright (c) 2015 Solaric Software LLC. All rights reserved.
//

#import "DrawPadView.h"

@implementation DrawPadView {
    CGPoint _points[7];
}

- (id) initWithDrawType: (ToolType) toolType StartPoint: (CGPoint) startPoint EndPoint: (CGPoint) endPoint Color: (UIColor *) color Weight: (CGFloat) weight {
    CGRect frame = CGRectMake(startPoint.x, startPoint.y, endPoint.x - startPoint.x, endPoint.y - startPoint.y);
    if (self = [super initWithFrame:frame]) {
        _toolType = toolType;
        _startPoint = startPoint;
        _endPoint = endPoint;
        _color = color;
        _weight = weight;
        _dotButtonSize = 25;
        _panViewSize = 40;
        
        self.clipsToBounds = NO;
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor greenColor].CGColor;
        self.layer.borderWidth = 1;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:tap];
        
//        _panView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//        _panView.backgroundColor = [UIColor clearColor];
//        _panView.layer.borderColor= [UIColor grayColor].CGColor;
//        _panView.layer.borderWidth = 1;
//        [self addSubview:_panView];
//        [self bringSubviewToFront:_panView];
//        
//        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panning:)];
//        [_panView addGestureRecognizer:pan];
//        
//        UITapGestureRecognizer *panTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panTapped:)];
//        [_panView addGestureRecognizer:panTap];
    }
    
    return self;
}

//- (void) tapped: (UITapGestureRecognizer *) sender {
//    if ([UIView alphaFromPoint:[sender locationInView:sender.view] withLayer:self.layer] > 0) {
//        [self setIsSelected:YES];
//        
//        NSLog(@"Color Found");
//        
//        if ([_delegate respondsToSelector:@selector(toolTouched:inView:)]) {
//            [_delegate toolTouched:YES inView:self];
//        }
//    } else {
//        [self setIsSelected:NO];
//        
//        NSLog(@"NO Color Found");
//        
//        if ([_delegate respondsToSelector:@selector(toolTouched:inView:)]) {
//            [_delegate toolTouched:NO inView:self];
//        }
//    }
//}

//- (void) panTapped: (UITapGestureRecognizer *) sender {
//    [self setIsSelected:YES];
//    
//    if ([_delegate respondsToSelector:@selector(toolTouched:inView:)]) {
//        [_delegate toolTouched:YES inView:self];
//    }
//}

//- (void) panning: (UIPanGestureRecognizer *) sender {
//    if (sender.state == UIGestureRecognizerStateBegan) {
//        if ([_delegate respondsToSelector:@selector(drawPardViewPanBegin:endPoint:inView:)]) {
//            [_delegate drawPardViewPanBegin:_startPoint endPoint:_endPoint inView:self];
//        }
//    }
//    
//    UIView *parent = sender.view.superview;
//    CGPoint translation = [sender translationInView:sender.view];
//    parent.center=CGPointMake(parent.center.x+translation.x, parent.center.y+ translation.y);
//    [sender setTranslation:CGPointMake(0, 0) inView:sender.view];
//    
//    if (sender.state == UIGestureRecognizerStateEnded) {
//        CGFloat distX = parent.frame.origin.x - _lastFrame.origin.x;
//        CGFloat distY = parent.frame.origin.y - _lastFrame.origin.y;
//        
//        _startPoint = CGPointMake(_startPoint.x + distX, _startPoint.y + distY);
//        _endPoint = CGPointMake(_endPoint.x + distX, _endPoint.y + distY);
//        
//        [self updateUI];
//        
//        if ([_delegate respondsToSelector:@selector(drawPardViewPanComplete:endPoint:inView:)]) {
//            [_delegate drawPardViewPanComplete:_startPoint endPoint:_endPoint inView:self];
//        }
//    }
//}

- (void) updateStartPoint: (CGPoint) startPoint {
    _startPoint = startPoint;
    [self updateUI];
}

- (void) updateEndPoint: (CGPoint) endPoint {
    _endPoint = endPoint;
    [self updateUI];
}

- (void) updateStartPoint: (CGPoint) startPoint EndPoint: (CGPoint) endPoint {
    _startPoint = startPoint;
    _endPoint = endPoint;
    
    self.frame = CGRectMake(_startPoint.x, _startPoint.y, _endPoint.x - _startPoint.x, _endPoint.y - _startPoint.y);
    [self setNeedsDisplay];
}

- (void) arrowClicked: (ArrowView *) sender {
    [self setIsSelected:YES];
}

- (void) setIsSelected: (BOOL) isSelected {
    if (isSelected) {
        [self updateUI];
    } else {
        [_startDotButton removeFromSuperview];
        _startDotButton = nil;
        
        [_endDotButton removeFromSuperview];
        _endDotButton = nil;
    }
    
    [_arrow setIsSelected:isSelected];
    if ([_delegate respondsToSelector:@selector(drawPadViewTouched:View:)]) {
        [_delegate drawPadViewTouched: isSelected View: self];
    }
}

- (void) dotButtonTouchBegan: (DotButton *) button {
    _dotButtonIndex = kDotButtonFirst;
    if (button == _endDotButton) {
        _dotButtonIndex = kDotButtonSecond;
    }
    
    if ([_delegate respondsToSelector:@selector(dotTouchBegan:inView:forIndex:)]) {
        [_delegate dotTouchBegan:button inView:self forIndex:_dotButtonIndex];
    }
}

- (void) dotButtonTouchEnded: (DotButton *) button {
    _dotButtonIndex = kDotButtonFirst;
    if (button == _endDotButton) {
        _dotButtonIndex = kDotButtonSecond;
    }
    
    if ([_delegate respondsToSelector:@selector(dotTouchEnded:inView:forIndex:)]) {
        [_delegate dotTouchEnded:button inView:self forIndex:_dotButtonIndex];
    }
}

- (void) updateColor: (UIColor *) color {
    _color = color;
    [_arrow updateColor: color];
}

- (void) updateWeight: (CGFloat) weight {
    _weight = weight;
    [_arrow updateWeight: weight];
}

- (void) updateUI {
    BOOL selected = _arrow.isSelected;
    [_arrow removeFromSuperview];
    _arrow = nil;
    
    CGFloat angle = [self caluclateAngleWithStartPoint:_startPoint EndPoint:_endPoint];
    CGRect frame;
    CGFloat width = _endPoint.x - _startPoint.x;
    CGFloat height = _endPoint.y - _startPoint.y;
    
    CGFloat min = 20;
    if (width >= 0 && width < min) {
        width = min;
    } else if (height >= 0 && height < min) {
        height = min;
    } else if (width < 0 && width > -20) {
        width = -min;
    } else if (height < 0 && height > -20) {
        height = -min;
    }
    
    self.layer.anchorPoint = CGPointMake(0, 0);
    
    //NSLog(@"Angle: %f", angle);
    
    self.frame = CGRectMake(_startPoint.x, _startPoint.y, 0, 0);
    self.bounds = CGRectMake(0, 0, 3000, 30000);
    //self.center = _startPoint;
    
    frame = CGRectMake(0, 0, width, 20);
//    if (angle >= 0 && angle <= 1.5) {
//        //Lower Right
//        NSLog(@"Quadrant: Lower Right");
//    } else if (angle > 1.5 && angle <= 3.2) {
//        //Lower Left
//        NSLog(@"Quadrant: Lower Left");
//    } else if (angle >= -3.2 && angle <= -1.5) {
//        //Upper Left
//        NSLog(@"Quadrant: Upper Left");
//    } else {
//        //Upper Right
//        NSLog(@"Quadrant: Upper Right");
//    }
    
    _arrow = [[ArrowView alloc] initWithFrame:frame withColor:_color withWeight:_weight withStartPoint:_startPoint withEndPoint:_endPoint];
    _arrow.delegate = self;
    //_arrow.bounds = CGRectMake(0,0,0,0);
    [_arrow setIsSelected:selected];
    [self addSubview:_arrow];
    [self bringSubviewToFront:_arrow];
    [self setNeedsDisplay];
    
//    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
//    _panView.frame = CGRectMake(center.x - (_panViewSize / 2), center.y - (_panViewSize / 2), _panViewSize, _panViewSize);
//    [self bringSubviewToFront:_panView];
    
    _lastFrame = self.frame;
}

- (void) pathUpdated: (UIBezierPath *) path inView: (UIView *) view {
//    [_startDotButton removeFromSuperview];
//    CGRect startDotFrame = CGRectMake(-5, -2.5, _dotButtonSize, _dotButtonSize);
//    _startDotButton = [[DotButton alloc] initWithFrame: startDotFrame DotSize:_dotButtonSize Color:[UIColor greenColor] InnerColor:[UIColor whiteColor]];
//    _startDotButton.backgroundColor = [UIColor clearColor];
//    _startDotButton.delegate = self;
//    [self addSubview:_startDotButton];
//    [self bringSubviewToFront:_startDotButton];
//    
//    [_endDotButton removeFromSuperview];
//    CGRect endDotFrame = CGRectMake(path.bounds.size.width - (_dotButtonSize - 2.5), -2.5, _dotButtonSize, _dotButtonSize);
//    _endDotButton = [[DotButton alloc] initWithFrame: endDotFrame DotSize:_dotButtonSize Color:[UIColor greenColor] InnerColor:[UIColor whiteColor]];
//    _endDotButton.backgroundColor = [UIColor clearColor];
//    _endDotButton.delegate = self;
//    [self addSubview:_endDotButton];
//    [self bringSubviewToFront:_endDotButton];
    
//    CGPoint center = CGPointMake(path.bounds.size.width / 2, path.bounds.size.height / 2);
//    _panView.frame = CGRectMake(center.x - (_panViewSize / 2), center.y - (_panViewSize / 2), _panViewSize, _panViewSize);
//    [self bringSubviewToFront:_panView];
    
    //NSLog(@"\n\nself.frame: %@ \npath.bounds: %@\n\n", NSStringFromCGRect(self.frame), NSStringFromCGRect(path.bounds));
}

- (CGFloat) caluclateAngleWithStartPoint: (CGPoint) startPoint EndPoint: (CGPoint) endPoint {
    CGFloat dx = endPoint.x - startPoint.x;
    CGFloat dy = endPoint.y - startPoint.y;

    return atan2(dy, dx);
}

+ (NSString *) toolTypeToString: (ToolType) toolType {
    NSString *retval;
    
    switch (toolType) {
        case kToolTypeArrow:
            retval = @"kToolTypeArrow";
            break;
        case KToolTypeCircle:
            retval = @"KToolTypeCircle";
        case kToolTypeSquare:
            retval = @"kToolTypeSquare";
            break;
        default:
            retval = @"";
            break;
    }
    
    return retval;
}

+ (ToolType) toolTypeFromString: (NSString *) str {
    ToolType retval;
    
    if ([str isEqual: @"kToolTypeArrow"]) {
        retval = kToolTypeArrow;
    } else if ([str isEqual: @"kToolTypeCircle"]) {
        retval = KToolTypeCircle;
    } else if ([str isEqual: @"kToolTypeSquare"]) {
        retval = kToolTypeSquare;
    }
    
    return retval;
}

@end
