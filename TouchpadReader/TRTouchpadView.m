//
//  TRAppController.m
//  TouchpadReader
//
//  Created by Lasse Lauwerys on 23/11/24.
//  Copyright (c) 2024 Lasse Lauwerys. All rights reserved.
//

#import "TRTouchpadView.h"

@implementation TRTouchpadView

- (id)init
{
    self = [super init];
    if (self) {
        [self setAcceptsTouchEvents:YES];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setAcceptsTouchEvents:YES];
    [self setViewScaling:TRTouchpadViewScalingTrueSize];
}

- (void)touchesBeganWithEvent:(NSEvent *)event
{
    [self touchesChangedWithEvent:event];
}

- (void)touchesMovedWithEvent:(NSEvent *)event
{
    [self touchesChangedWithEvent:event];
}

- (void)touchesCancelledWithEvent:(NSEvent *)event
{
    [self touchesChangedWithEvent:event];
}

- (void)touchesEndedWithEvent:(NSEvent *)event
{
    [self touchesChangedWithEvent:event];
}

- (void)touchesChangedWithEvent:(NSEvent *)event
{
    NSSet *allTouches = [event touchesMatchingPhase:NSTouchPhaseAny inView:self];
    [self setTouches:allTouches];
    [self setNeedsDisplay:YES];
}

- (void)drawCircle:(NSRect)rect
{
    NSColor *fillColor = [NSColor redColor];
    rect.origin.x -= rect.size.width / 2;
    rect.origin.y -= rect.size.height / 2;
    NSBezierPath *path = [NSBezierPath bezierPathWithOvalInRect:rect];
    [fillColor setFill];
    [path fill];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    NSLog(@"%li", [[self touches] count]);
    for (NSTouch *touch in [self touches]) {
        NSPoint fraction = touch.normalizedPosition;
        NSSize deviceSize = touch.deviceSize;
        
        NSRect frame;
        
        switch ([self viewScaling]) {
            case TRTouchpadViewScalingPointsToPixels:
                frame.size = deviceSize; // It also gives x and y, what are these?
                frame.origin = [[self window] frame].origin;
                break;
                
            case TRTouchpadViewScalingTrueSize:
            {
                NSScreen *screen = [NSScreen mainScreen];
                NSDictionary *description = [screen deviceDescription];
                NSSize displayPixelSize = [[description objectForKey:NSDeviceSize] sizeValue];
                CGSize displayPhysicalSize = CGDisplayScreenSize([[description objectForKey:@"NSScreenNumber"] unsignedIntValue]);
                
                NSSize displayDpi;
                displayDpi.width = (displayPixelSize.width / displayPhysicalSize.width) * 25.4f;
                displayDpi.height = (displayPixelSize.height / displayPhysicalSize.height) * 25.4f;
                
                NSSize dpiDifference;
                dpiDifference.width = displayDpi.width / 72;
                dpiDifference.height = displayDpi.height / 72;                
                deviceSize.width *= dpiDifference.width;
                deviceSize.height *= dpiDifference.height;
                
                frame.size = deviceSize;
            }
                break;
        }
        [[self window] setFrame:frame display:YES];
        
        fraction.x *= dirtyRect.size.width;
        fraction.y *= dirtyRect.size.height;
        NSRect rect;
        rect.origin = fraction;
        rect.size.width = 10;
        rect.size.height = 10;
        [self drawCircle:rect];
    }
}

@end
