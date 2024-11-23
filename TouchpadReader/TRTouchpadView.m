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
    NSLog(@"I woke from nicb");
    [self setAcceptsTouchEvents:YES];
    [self drawCircle:NSMakeRect(0, 0, 100, 100)];
}

- (void)touchesBeganWithEvent:(NSEvent *)event
{
    NSLog(@"Yup they did");
    //[event locationInWindow];
//    [event pressure];
    NSSet *touches = [event touchesMatchingPhase:NSTouchPhaseBegan inView:self];
    for (NSTouch *touch in touches) {
        NSPoint fraction = [touch normalizedPosition];
        NSSize whole = touch.deviceSize;
        NSPoint wholeInches = {whole.width / 72.0, whole.height / 72.0};
        NSPoint pos = wholeInches;
        pos.x *= fraction.x;
        pos.y *= fraction.y;
        NSLog(@"%s: Finger is touching %g inches right and %g inches up "
              @"from lower left corner of trackpad.", __func__, fraction.x, fraction.y);
    }
}

- (void)touchesMovedWithEvent:(NSEvent *)event
{
    NSSet *touches = [event touchesMatchingPhase:NSTouchPhaseMoved inView:self];
    for (NSTouch *touch in touches) {
        NSPoint fraction = touch.normalizedPosition;
        NSLog(@"%s: Finger is touching %g inches right and %g inches up "
              @"from lower left corner of trackpad.", __func__, fraction.x, fraction.y);
        NSRect rect;
        rect.origin = fraction;
        rect.size.width = 10;
        rect.size.height = 10;
        [self drawCircle:rect];
    }
    NSSet *allTouches = [event touchesMatchingPhase:NSTouchPhaseAny inView:self];
    [self setTouches:allTouches];
    [self setNeedsDisplay:YES];
//    [self setTouchCount:[allTouches count]];
//    NSPointArray points = calloc(, sizeof(NSPoint));
//    for (int i = 0; i < [allTouches count]; <#increment#>) {
//        <#statements#>
//    }
//    [self setTouches:];
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
        fraction.x *= 10;
        fraction.y *= 10;
        NSRect rect;
        rect.origin = fraction;
        rect.size.width = 10;
        rect.size.height = 10;
        [self drawCircle:rect];
    }
    
    NSColor *fillColor = [NSColor redColor];
    NSBezierPath *path = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(0, 0, 100, 100)];
    [fillColor setFill];
    [path fill];
}

@end
