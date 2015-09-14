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
    CGPoint _startPoint;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _selectedColor = [UIColor yellowColor];
    _selectedWeight = 3;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.view addGestureRecognizer:pan];
}

- (void) panHandler: (UIPanGestureRecognizer *) sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        //Instantiate the arrow
        CGPoint touchPoint = [sender locationInView:sender.view];
        _startPoint = touchPoint;
        _selectedArrowView = [[ArrowView alloc] initWithFrame:CGRectMake(touchPoint.x, touchPoint.y, 0, 25) withColor:_selectedColor withWeight:_selectedWeight];
        _selectedArrowView.delegate = self;
        [self.view addSubview:_selectedArrowView];
        [self.view bringSubviewToFront:_selectedArrowView];
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        //"Draw" the arrow based upon finger postion
        CGPoint touchPoint = [sender locationInView:sender.view];
        [_selectedArrowView drawArrow:_startPoint to:touchPoint];
    }
}

@end
