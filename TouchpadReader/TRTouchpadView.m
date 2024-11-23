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
}

- (void)touchesBeganWithEvent:(NSEvent *)event
{
    NSLog(@"Yup they did");
    //[event locationInWindow];
//    [event pressure];
    NSSet *touches = [event touchesMatchingPhase:NSTouchPhaseBegan inView:self];
    for (NSTouch *touch in touches) {
        NSPoint fraction = touch.normalizedPosition;
        NSSize whole = touch.deviceSize;
        NSPoint wholeInches = {whole.width / 72.0, whole.height / 72.0};
        NSPoint pos = wholeInches;
        pos.x *= fraction.x;
        pos.y *= fraction.y;
        NSLog(@"%s: Finger is touching %g inches right and %g inches up "
              @"from lower left corner of trackpad.", __func__, pos.x, pos.y);
    }
}

@end
