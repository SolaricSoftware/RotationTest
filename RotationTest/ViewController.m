//
//  ViewController.m
//  RotationTest
//
//  Created by Olan Hall on 9/7/15.
//  Copyright (c) 2015 Solaric Software LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    ArrowView *_selectedArrowView;
    UIColor *_selectedColor;
    CGFloat _selectedWeight;
    CGFloat _initalAngle;
    DotButtonIndex _dotButtonIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _selectedColor = [UIColor yellowColor];
    _selectedWeight = 3;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.view addGestureRecognizer:pan];
    
    _selectedArrowView = [[ArrowView alloc] initWithFrame:CGRectMake(300, 300, 150, 25) withColor:_selectedColor withWeight:_selectedWeight withStartPoint:CGPointMake(300, 300) withEndPoint:CGPointMake(450, 300)];
    _selectedArrowView.delegate = self;
    _selectedArrowView.layer.anchorPoint = CGPointMake(0, 0);
    _selectedArrowView.layer.position = CGPointMake(150, 300);
    [self.view addSubview:_selectedArrowView];
    [self.view bringSubviewToFront:_selectedArrowView];
}

- (void) panHandler: (UIPanGestureRecognizer *) sender {
    CGPoint touchPoint = [sender locationInView:sender.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        _initalAngle = atan2(touchPoint.y, touchPoint.x);
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        CGFloat currentAngle = atan2(touchPoint.y, touchPoint.x);
        CGFloat angle = _initalAngle - currentAngle;
        CGAffineTransform transform = CGAffineTransformMakeRotation(angle * -1);
        _selectedArrowView.transform = transform;
    }
}

@end
