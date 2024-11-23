//
//  TRAppController.h
//  TouchpadReader
//
//  Created by Lasse Lauwerys on 23/11/24.
//  Copyright (c) 2024 Lasse Lauwerys. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    TRTouchpadViewScalingPointsToPixels,
    TRTouchpadViewScalingTrueSize
};
typedef NSUInteger TRTouchpadViewScaling;

@interface TRTouchpadView : NSView

@property NSSet *touches;
@property TRTouchpadViewScaling viewScaling;


@end
