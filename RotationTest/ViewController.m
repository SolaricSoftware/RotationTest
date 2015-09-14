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
//    CGFloat _initalAngle;
//    CGFloat _angle;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _selectedColor = [UIColor yellowColor];
    _selectedWeight = 3;
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
//    [self.view addGestureRecognizer:pan];
    
    _selectedArrowView = [[ArrowView alloc] initWithFrame:CGRectMake(100, 100, 150, 25) withColor:_selectedColor withWeight:_selectedWeight];
    _selectedArrowView.delegate = self;
    //_selectedArrowView.layer.anchorPoint = CGPointMake(0, 0.5);
    //_selectedArrowView.layer.position = CGPointMake(150,100);
    [self.view addSubview:_selectedArrowView];
    [self.view bringSubviewToFront:_selectedArrowView];
}

//- (void) panHandler: (UIPanGestureRecognizer *) sender {
//    //CGPoint touchPoint = [sender locationInView:sender.view];
//    
//    if (sender.state == UIGestureRecognizerStateBegan) {
//        _initalAngle = pToA(sender, _selectedArrowView);
//    } else if (sender.state == UIGestureRecognizerStateChanged) {
//        _angle = pToA(sender, _selectedArrowView);
//        _angle -= _initalAngle;
//        CGAffineTransform transform = CGAffineTransformMakeRotation(_angle);
//        _selectedArrowView.transform = transform;
//    } else if (sender.state == UIGestureRecognizerStateEnded) {
//        _selectedArrowView.currentAngle = _angle;
//    }
//}

//static CGFloat pToA (UIGestureRecognizer * sender, UIView* view) {
//    CGPoint loc = [sender locationInView: sender.view];
//    CGPoint c = CGPointMake(CGRectGetMinX(view.bounds),
//                            CGRectGetMinY(view.bounds));
//    return atan2(loc.y - c.y, loc.x - c.x);
//}

@end
