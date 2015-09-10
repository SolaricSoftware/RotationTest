//
//  DotButton.h
//  ImageAnno
//
//  Created by Olan Hall on 9/2/15.
//  Copyright (c) 2015 Solaric Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DotButtonDelegate;

typedef enum {
    kDotButtonFirst,
    kDotButtonSecond
} DotButtonIndex;

@interface DotButton : UIButton {
    CAShapeLayer *_dotLayer;
}

@property CGFloat dotSize;
@property UIColor *color;
@property UIColor *innerColor;
@property id <DotButtonDelegate> delegate;

- (id) initWithFrame: (CGRect) frame DotSize: (CGFloat) dotSize Color: (UIColor *) color InnerColor: (UIColor *) innerColor;

@end

@protocol DotButtonDelegate <NSObject>

@optional
- (void) dotButtonTouchBegan: (DotButton *) button;
- (void) dotButtonTouchEnded: (DotButton *) button;

@end
