//
//  simulatorAppDelegate.h
//  Robot Simulation
//
//  Created by Bradley Delaune on 2/14/13.
//  Copyright (c) 2013 Senior Design. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AMSerialPort.h"
#import "robotOpenGL.h"

@interface simulatorAppDelegate : NSObject <NSApplicationDelegate>{
    AMSerialPort *port;
    IBOutlet NSTextField *statusField;
    IBOutlet robotOpenGL *robotSimulation;
    IBOutlet NSView *connectView;
    IBOutlet NSButton *disconnectButton;
    IBOutlet NSButton *connectButton;
    IBOutlet NSPopUpButton *portList;
    float power;
    IBOutlet NSProgressIndicator *spinner;
}


//@property
@property (assign) IBOutlet NSWindow *window;
- (IBAction)connect:(id)sender;
- (IBAction)disconnect:(id)sender;
- (void)listDevices;
- (void)initPort;
- (AMSerialPort *)port;
- (void) setPort:(AMSerialPort *)newPort;
- (void)didAddPorts:(NSNotification *)theNotification;
- (void)didRemovePorts:(NSNotification *)theNotification;
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication;
@end
