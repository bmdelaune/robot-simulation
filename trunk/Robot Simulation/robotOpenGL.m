//
//  robotOpenGL.m
//  Robot Simulation
//
//  Created by Bradley Delaune on 2/14/13.
//  Copyright (c) 2013 Senior Design. All rights reserved.
//

#import "robotOpenGL.h"
#include <OpenGL/gl.h>

@implementation robotOpenGL

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self  setWantsBestResolutionOpenGLSurface:YES];
    }
    
    return self;
}

- (void) drawRobot
{
    glColor3f(1.0f, 1.0f, 1.0f);
    glBegin(GL_POLYGON); // draws large white body
    {
        glVertex3f(-0.5, 0.6, 0.0);
        glVertex3f( 0.5, 0.6, 0.0);
        glVertex3f( 0.5, -0.6 ,0.0);
        glVertex3f(-0.5, -0.6 ,0.0);
    }
    glEnd();
    
    glColor3f(0.0f, 0.0f, 0.0f);
    glBegin(GL_POLYGON); // draws smaller black box
    {
        glVertex3f(-0.45, 0.55, 0.0);
        glVertex3f( 0.45, 0.55, 0.0);
        glVertex3f( 0.45, -0.55 ,0.0);
        glVertex3f(-0.45, -0.55 ,0.0);
    }
    glEnd();
    
    glColor3f(1.0f, 1.0f, 1.0f);
    glBegin(GL_POLYGON); // draws middle beam
    {
        glVertex3f(-0.5, 0.30, 0.0);
        glVertex3f( 0.5, 0.30, 0.0);
        glVertex3f( 0.5, 0.25 ,0.0);
        glVertex3f(-0.5, 0.25 ,0.0);
    }
    glEnd();
    
    glColor3f(0.0f, 0.0f, 1.0f);
    glBegin(GL_POLYGON); // TL motor
    {
        glVertex3f(-0.43, 0.26, 0.0);
        glVertex3f(-0.39, 0.22, 0.0);
        glVertex3f(-0.47, 0.14 ,0.0);
        glVertex3f(-0.51, 0.18 ,0.0);
    }
    glEnd();
    glBegin(GL_POLYGON); // TR motor
    {
        glVertex3f(0.43, 0.26, 0.0);
        glVertex3f(0.39, 0.22, 0.0);
        glVertex3f(0.47, 0.14 ,0.0);
        glVertex3f(0.51, 0.18 ,0.0);
    }
    glEnd();
    glBegin(GL_POLYGON); // BL motor
    {
        glVertex3f(-0.29,-0.64, 0.0);
        glVertex3f(-0.25,-0.60, 0.0);
        glVertex3f(-0.33,-0.52 ,0.0);
        glVertex3f(-0.37,-0.56 ,0.0);
    }
    glEnd();
    glBegin(GL_POLYGON); // BR motor
    {
        glVertex3f(0.29,-0.64, 0.0);
        glVertex3f(0.25,-0.60, 0.0);
        glVertex3f(0.33,-0.52 ,0.0);
        glVertex3f(0.37,-0.56 ,0.0);
    }
    glEnd();
    
    glColor3f(1.0f, 1.0f, 1.0f);
    glBegin(GL_POLYGON); // slant left
    {
        glVertex3f(-0.45, 0.30, 0.0);
        glVertex3f(-0.25,-0.55, 0.0);
        glVertex3f(-0.30,-0.55 ,0.0);
        glVertex3f(-0.5, 0.25 ,0.0);
    }
    glEnd();
    
    glBegin(GL_POLYGON); // slant right
    {
        glVertex3f(0.45,0.30, 0.0);
        glVertex3f(0.25,-0.55, 0.0);
        glVertex3f(0.30,-0.55 ,0.0);
        glVertex3f(0.5,0.25 ,0.0);
    }
    glEnd();
}

- (void) drawArrow:(float)size :(NSString*)which
{
    if(size > 100.0) size = 100.0;
    if(size < -100.0) size = -100.0;
    float d = size/250;
    
    float color = size/100.0;
    if(color < 0)
        color*=-1;
    
    NSLog(@"d = %f",d);
    NSLog(@"color = %f",color);
    
    glColor3f(color,1-color, 0.0f);
    glBegin(GL_POLYGON); // TL motor
    {
        float x1 = 0.0;
        float x2 = 0.0;
        float y1 = 0.0;
        float y2 = 0.0;
        float x3 = 0.0;
        float x4 = 0.0;
        float y3 = 0.0;
        float y4 = 0.0;
        if([which isEqualToString:@"TL"]){
            d = -d;
            x1 = -0.47;
            y1 = 0.22;
            x2 = -0.43;
            y2 = 0.18;
            x3 = x2+d;
            y3 = y2+d;
            x4 = x1+d;
            y4 = y1+d;
        } else if([which isEqualToString:@"TR"]){
            d = -d;
            x1 = 0.47;
            y1 = 0.22;
            x2 = 0.43;
            y2 = 0.18;
            x3 = x2-d;
            y3 = y2+d;
            x4 = x1-d;
            y4 = y1+d;
        } else if([which isEqualToString:@"BR"]){
            x2 = 0.29;
            y2 = -0.56;
            x1 = 0.33;
            y1 = -0.60;
            x3 = x2-d;
            y3 = y2-d;
            x4 = x1-d;
            y4 = y1-d;
        } else if([which isEqualToString:@"BL"]){
            x1 = -0.33;
            y1 = -0.60;
            x2 = -0.29;
            y2 = -0.56;
            x3 = x2+d;
            y3 = y2-d;
            x4 = x1+d;
            y4 = y1-d;
        } else if([which isEqualToString:@"UD"]){
            x1 = -1.00;
            y1 = 0.00;
            x2 = -0.95;
            y2 = 0.00;
            x3 = x2;
            y3 = y2-d;
            x4 = x1;
            y4 = y1-d;
        } else {
            NSLog(@"Error %@ is not a valid motor indication", which);
        }
        //glColor3f(0.0, 1.0, 0.0);
        glVertex3f(x1, y1, 0.0);
        //glColor3f(0.0, 1.0, 0.0);
        glVertex3f(x2, y2, 0.0);
        //glColor3f(d, 0.0, 0.0);
        glVertex3f(x3, y3, 0.0);
        //glColor3f(d, 0.0, 0.0);
        glVertex3f(x4, y4, 0.0);
    }
    glEnd();
}

/*!
 redrawRobot
 is awesome!
*/
- (void) redrawRobot:(float)tl :(float)tr :(float)br :(float)bl :(float)ud
{
    glClear(GL_COLOR_BUFFER_BIT);
    [self drawRobot];
    [self drawArrow:tl:@"TL"];
    [self drawArrow:tr:@"TR"];
    [self drawArrow:br:@"BR"];
    [self drawArrow:bl:@"BL"];
    [self drawArrow:ud:@"UD"];
    glFlush();
}

- (void)drawRect:(NSRect)dirtyRect
{
    glClearColor (0.0, 0.0, 0.0, 0.0);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_LINE_SMOOTH);
    glShadeModel (GL_SMOOTH);
    glClear(GL_COLOR_BUFFER_BIT);
    [self drawRobot];
    glFlush();
}

@end
