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
    CGPoint _endPoint;
    NSMutableArray *_arrowViews;
    
    UIView *tmp;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrowViews = [NSMutableArray new];

    _selectedColor = [UIColor yellowColor];
    _selectedWeight = 3;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    tmp = [[UIView alloc] initWithFrame:CGRectMake(screenWidth / 4, screenHeight / 4, screenWidth / 2, screenHeight / 2)];
    tmp.backgroundColor = [UIColor redColor];
    [self.view addSubview:tmp];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.view addGestureRecognizer:pan];
}

- (void) panHandler: (UIPanGestureRecognizer *) sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        //Instantiate the arrow
        CGPoint touchPoint = [sender locationInView:sender.view];
        _startPoint = touchPoint;
        _selectedArrowView = [[ArrowView alloc] initWithFrame:CGRectMake(touchPoint.x, touchPoint.y, 300, 25) withColor:_selectedColor withWeight:_selectedWeight];
        _selectedArrowView.delegate = self;
        [self.view addSubview:_selectedArrowView];
        [self.view bringSubviewToFront:_selectedArrowView];
        
        [_arrowViews addObject:_selectedArrowView];
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        //"Draw" the arrow based upon finger postion
        _endPoint = [sender locationInView:sender.view];
        [_selectedArrowView drawArrow:_startPoint to:_endPoint];
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [_selectedArrowView setIsSelected:YES];
    }
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    tmp.frame = CGRectMake(screenWidth / 4, screenHeight / 4, screenWidth / 2, screenHeight / 2);
    
    for (ArrowView *view in _arrowViews) {
        //How do I reposition the arrow views?
        [view changeOrientation:toInterfaceOrientation];
    }
    
}

@end
