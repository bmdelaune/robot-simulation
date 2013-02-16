//
//  robotOpenGL.h
//  Robot Simulation
//
//  Created by Bradley Delaune on 2/14/13.
//  Copyright (c) 2013 Senior Design. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface robotOpenGL : NSOpenGLView

- (void) drawRect: (NSRect) bounds;
- (void) drawRobot;
- (void) drawArrow: (float) size :(NSString*) which;
- (void) redrawRobot: (float) tl :(float) tr :(float) br :(float) bl :(float) ud;

@end
