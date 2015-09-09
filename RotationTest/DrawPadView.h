//
//  DrawPadView.h
//  ImageAnno
//
//  Created by Olan Hall on 9/1/15.
//  Copyright (c) 2015 Solaric Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrowView.h"
#import "DotButton.h"
#import "UIView+Color.h"

typedef enum  {
    kToolTypeArrow,
    kToolTypeSquare,
    KToolTypeCircle
} ToolType;

@protocol DrawPadViewDelegate;

typedef enum {
    kDotButtonFirst,
    kDotButtonSecond
} DotButtonIndex;

@interface DrawPadView : UIView <ArrowViewDelegate, DotButtonDelegate> {
    CGFloat _tailWidth;
    CGFloat _headWidth;
    CGFloat _headLength;
    ArrowView *_arrow;
    DotButton *_startDotButton;
    DotButton *_endDotButton;
    CGFloat _dotButtonSize;
    CGFloat _panViewSize;
    UIView *_panView;
    CGRect _lastFrame;
}
@property id <DrawPadViewDelegate> delegate;
@property CGPoint startPoint;
@property CGPoint endPoint;
@property CGFloat weight;
@property UIColor *color;
@property ToolType toolType;
@property DotButtonIndex dotButtonIndex;

- (id) initWithDrawType: (ToolType) drawType StartPoint: (CGPoint) startPoint EndPoint: (CGPoint) endPoint Color: (UIColor *) color Weight: (CGFloat) weight;
- (void) updateStartPoint: (CGPoint) startPoint;
- (void) updateEndPoint: (CGPoint) endPoint;
- (void) updateStartPoint: (CGPoint) startPoint EndPoint: (CGPoint) endPoint;
- (void) setIsSelected: (BOOL) isSelected;
- (void) updateColor: (UIColor *) color;
- (void) updateWeight: (CGFloat) weight;

+ (NSString *) toolTypeToString: (ToolType) toolType;
+ (ToolType) toolTypeFromString: (NSString *) str;

@end

@protocol DrawPadViewDelegate <NSObject>

@optional

- (void) drawPadViewTouched: (BOOL) selected View: (DrawPadView *) view;
- (void) drawPardViewPanBegin: (CGPoint) startPoint endPoint: (CGPoint) endPoint inView: (DrawPadView *) view;
- (void) drawPardViewPanComplete: (CGPoint) startPoint endPoint: (CGPoint) endPoint inView: (DrawPadView *) view;
- (void) toolTouched: (BOOL) selected inView: (DrawPadView *) view;
- (void) dotTouchBegan: (DotButton *) button inView: (DrawPadView *) view forIndex: (DotButtonIndex) index;
- (void) dotTouchEnded: (DotButton *) button inView: (DrawPadView *) view forIndex: (DotButtonIndex) index;

@end
