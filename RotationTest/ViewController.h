//
//  ViewController.h
//  RotationTest
//
//  Created by Olan Hall on 9/7/15.
//  Copyright (c) 2015 Solaric Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawPadView.h"


@interface ViewController : UIViewController <DrawPadViewDelegate, ArrowViewDelegate, DotButtonDelegate> {
    UIView *_arrow;
}


@end

