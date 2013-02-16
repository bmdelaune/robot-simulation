//
//  serial.h
//  Robot Simulation
//
//  Created by Bradley Delaune on 2/14/13.
//  Copyright (c) 2013 Senior Design. All rights reserved.
//

#ifndef Robot_Simulation_serial_h
#define Robot_Simulation_serial_h

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <errno.h>
#include <paths.h>
#include <termios.h>
#include <sysexits.h>
#include <sys/param.h>
#include <sys/select.h>
#include <sys/time.h>
#include <time.h>

#include <CoreFoundation/CoreFoundation.h>

#include <IOKit/IOKitLib.h>
#include <IOKit/serial/IOSerialKeys.h>
#include <IOKit/IOBSD.h>

#endif
