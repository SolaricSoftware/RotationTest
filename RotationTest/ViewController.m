//
//  ViewController.m
//  RotationTest
//
//  Created by Olan Hall on 9/7/15.
//  Copyright (c) 2015 Solaric Software LLC. All rights reserved.
//

#import "ViewController.h"
#import "DrawPadView.h"

@interface ViewController ()

@end

@implementation ViewController {
    DrawPadView *_selectedDrawPad;
    UIView *_drawingLayer;
    CGPoint _startPoint;
    CGPoint _endPoint;
    UIColor *_selectedColor;
    CGFloat _selectedWeight;
    ToolType _selectedTool;
    BOOL _dotTouched;
    NSMutableArray *_drawPadViews;
    BOOL _isPanning;
    BOOL _panCanceled;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _selectedColor = [UIColor yellowColor];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_drawingLayer == nil) {
        _drawingLayer = [[UIView alloc] initWithFrame:self.view.frame];
        _drawingLayer.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_drawingLayer];
        [self.view bringSubviewToFront:_drawingLayer];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
        [_drawingLayer addGestureRecognizer:pan];
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
//        [self.view addGestureRecognizer:tap];
    }
}

- (void) panHandler: (UIPanGestureRecognizer *) sender {
    if (!_dotTouched) {
        if (!_isPanning && !_panCanceled) {
            _startPoint = [sender locationInView:sender.view];
            _endPoint = CGPointMake(_startPoint.x + 10, _startPoint.y + 10);
            
            _isPanning = YES;
            
            [_selectedDrawPad setIsSelected:NO];
            
            _selectedDrawPad = [[DrawPadView alloc] initWithDrawType:kToolTypeArrow StartPoint:_startPoint EndPoint:_endPoint Color:_selectedColor Weight:_selectedWeight];
            _selectedDrawPad.delegate = self;
            [_drawPadViews addObject:_selectedDrawPad];
            [_drawingLayer addSubview:_selectedDrawPad];
            [_drawingLayer bringSubviewToFront:_selectedDrawPad];
        } else {
            _endPoint = [sender locationInView:sender.view];
            
            if (!_panCanceled) {
                [_selectedDrawPad updateEndPoint:_endPoint];
            }
            
            CGFloat angle = [self caluclateAngleWithStartPoint:_startPoint EndPoint:_endPoint];
            CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
            _selectedDrawPad.transform = transform;
            
//            if (!CGRectContainsPoint(_imageView.bounds, _endPoint)) {
//                _panCanceled = YES;
//                _isPanning = NO;
//            } else {
//                _panCanceled = NO;
//                _isPanning = YES;
//            }
            
            if (sender.numberOfTouches == 0) {
                [_selectedDrawPad setIsSelected:YES];
                _isPanning = NO;
                _panCanceled = NO;
            }
        }
    } else {
        CGPoint touchPoint = [sender locationInView:sender.view];
        
        CGFloat xDist = (_selectedDrawPad.startPoint.x - touchPoint.x);
        CGFloat yDist = (_selectedDrawPad.startPoint.y - touchPoint.y);
        CGFloat distanceOne = sqrt((xDist * xDist) + (yDist * yDist));
        
        xDist = (touchPoint.x - _selectedDrawPad.endPoint.x);
        yDist = (touchPoint.y - _selectedDrawPad.endPoint.y);
        CGFloat distanceTwo = sqrt((xDist * xDist) + (yDist * yDist));
        
        CGFloat angle = [self caluclateAngleWithStartPoint:_startPoint EndPoint:_endPoint];
        CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
        _selectedDrawPad.transform = transform;
        //_selectedDrawPad.layer.anchorPoint = CGPointMake(0, 0);
        
        if (distanceOne < distanceTwo) {
            _startPoint = touchPoint;
            [_selectedDrawPad updateStartPoint:touchPoint];
        } else {
            _endPoint = touchPoint;
            [_selectedDrawPad updateEndPoint:touchPoint];
        }
        
        if (sender.numberOfTouches == 0) {
            _dotTouched = NO;
        }
    }
}

- (CGFloat) caluclateAngleWithStartPoint: (CGPoint) startPoint EndPoint: (CGPoint) endPoint {
    CGFloat dx = endPoint.x - startPoint.x;
    CGFloat dy = endPoint.y - startPoint.y;
    
    return atan2(dy, dx);
}

- (void) dotTouchBegan: (DotButton *) button inView: (DrawPadView *) view forIndex:(DotButtonIndex)index {
    _dotTouched = YES;
}

- (void) dotTouchEnded: (DotButton *) button inView: (DrawPadView *) view forIndex:(DotButtonIndex)index {
    _dotTouched = NO;
}

@end
