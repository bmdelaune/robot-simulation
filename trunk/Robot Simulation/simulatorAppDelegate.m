//
//  simulatorAppDelegate.m
//  Robot Simulation
//
//  Created by Bradley Delaune on 2/14/13.
//  Copyright (c) 2013 Senior Design. All rights reserved.
//

#import "simulatorAppDelegate.h"
#import "AMSerialPortList.h"
#import "AMSerialPortAdditions.h"

@implementation simulatorAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddPorts:) name:AMSerialPortListDidAddPortsNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRemovePorts:) name:AMSerialPortListDidRemovePortsNotification object:nil];
	
	/// initialize port list to arm notifications
	[AMSerialPortList sharedPortList];
	[self listDevices];
    [statusField setStringValue:@"Idle."];
}

- (void)listDevices
{
    // get an port enumerator
    NSEnumerator *enumerator = [AMSerialPortList portEnumerator];
    AMSerialPort *aPort;
    [portList removeAllItems];
    
    while (aPort = [enumerator nextObject]) {
        [portList addItemWithTitle:[aPort bsdPath]];
    }
}

- (IBAction)disconnect:(id)sender {
    /*power++;
    [robotSimulation redrawRobot:power :power :power :power :power];
    NSLog(@"Redrawn");*/
    [port close];
    
    [self setPort:nil];

    [statusField setStringValue:@"Connection Lost!"];
    [connectView setHidden:NO];
    [robotSimulation setHidden:YES];
    [connectButton setEnabled:YES];
    [disconnectButton setEnabled:NO];
}

- (IBAction)connect:(id)sender {
    [statusField setStringValue:@"Connecting..."];
    [spinner setHidden:NO];
    [spinner startAnimation:self];
    [self initPort];
}

- (void)initPort
{
   NSString *deviceName = [portList titleOfSelectedItem];
    if (![deviceName isEqualToString:[port bsdPath]]) {
        [port close];
        
        [self setPort:[[[AMSerialPort alloc] init:deviceName withName:deviceName type:(NSString*)CFSTR(kIOSerialBSDModemType)] autorelease]];
        [port setDelegate:self];
        
        if ([port open]) {
            
            //Then I suppose we connected!
            NSLog(@"successfully connected");
            
            [spinner stopAnimation:self];
            [spinner setHidden:YES];
            [connectButton setEnabled:NO];
            [disconnectButton setEnabled:YES];
            [statusField setStringValue:@"Connection Successful!"];
            [connectView setHidden:YES];
            [robotSimulation setHidden:NO];
            
            //TODO: Set appropriate baud rate here.
            
            //The standard speeds defined in termios.h are listed near
            //the top of AMSerialPort.h. Those can be preceeded with a 'B' as below. However, I've had success
            //with non standard rates (such as the one for the MIDI protocol). Just omit the 'B' for those.
			
            [port setSpeed:B38400];
            
            
            // listen for data in a separate thread
            [port readDataInBackground];
            
        } else { // an error occured while creating port
            
            NSLog(@"error connecting");
            [statusField setStringValue:@"Error Trying to Connect..."];
            [self setPort:nil];
            [spinner stopAnimation:self];
            [spinner setHidden:YES];
            
        }
    }
    NSLog(@"received initPort message");
}

- (void)serialPortReadData:(NSDictionary *)dataDictionary
{
    
    AMSerialPort *sendPort = [dataDictionary objectForKey:@"serialPort"];
    NSData *data = [dataDictionary objectForKey:@"data"];
    
    if ([data length] > 0) {
        
        NSString *receivedText = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"Serial Port Data Received: %@",receivedText);
        
        
        //TODO: Do something meaningful with the data...
        
        //Typically, I arrange my serial messages coming from the Arduino in chunks, with the
        //data being separated by a comma or semicolon. If you're doing something similar, a
        //variant of the following command is invaluable.
        
        //NSArray *dataArray = [receivedText componentsSeparatedByString:@","];
        
        
        // continue listening
        [sendPort readDataInBackground];
        
    } else {
        // port closed
        NSLog(@"Port was closed on a readData operation...not good!");
    }
    
}

- (AMSerialPort *)port
{
    return port;
}

- (void)setPort:(AMSerialPort *)newPort
{
    id old = nil;
    
    if (newPort != port) {
        old = port;
        port = [newPort retain];
        [old release];
    }
}

- (void)didAddPorts:(NSNotification *)theNotification
{
    NSLog(@"A port was added");
    [self listDevices];
}

- (void)didRemovePorts:(NSNotification *)theNotification
{
    NSLog(@"A port was removed");
    [self listDevices];
}

@end
