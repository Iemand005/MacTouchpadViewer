//
//  TRAppController.h
//  TouchpadReader
//
//  Created by Lasse Lauwerys on 23/11/24.
//  Copyright (c) 2024 Lasse Lauwerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRTouchpadView : NSView

//@property NSPointArray touches;
@property NSSet *touches;
@property NSInteger touchCount;

@end
