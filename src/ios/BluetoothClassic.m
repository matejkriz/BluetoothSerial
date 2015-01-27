//
//  BTConnectionManager.m
//
//  Created by Nathan Stryker on 11/26/14.
//  Copyright (c) 2014 Nathan Stryker. All rights reserved.
//
//  Modified by Matej Kri
//

#import "BluetoothClassic.h"
#import <ExternalAccessory/ExternalAccessory.h>

@implementation BluetoothClassic

#define EAD_INPUT_BUFFER_SIZE 4096

@synthesize peripherals;

peripherals = [[NSMutableArray alloc] initWithArray:[[EAAccessoryManager sharedAccessoryManager] connectedAccessories]];
#pragma mark reader code
// low level read method - read data while there is data and space available in the input buffer
- (void)readReceivedData{

  uint8_t buf[EAD_INPUT_BUFFER_SIZE];

  while ([[_session inputStream] hasBytesAvailable])
  {
    NSInteger bytesRead = [[_session inputStream] read:buf maxLength:EAD_INPUT_BUFFER_SIZE];
    if (_readData == nil) {
      _readData = [[NSMutableData alloc] init];

    }
    [_readData appendBytes:(void *)buf length:bytesRead];
  }

  uint8_t *s = (uint8_t*)self.readData.bytes;

  NSString *dataString = [[NSString alloc] init];

  for(unsigned int i = 0; i < _readData.length; i++){
    dataString = [dataString stringByAppendingFormat:@"%02x", s[i]];
    dataString = [dataString stringByAppendingFormat:@" "];
  }
  //NSLog(@"------Message String %@", debugString);

  [self parseDataStream:dataString];

  _readData = nil;

}

#pragma mark Public Methods
// open a session with the accessory and set up the input and output stream on the default run loop
- (BOOL)openSession{

  _buffer = [[NSString alloc] init];

  if(_session){
    [self closeSession];
  }

  //input your own protocol string
  [self openSessionForProtocol:@""];

  if(!_session){
    return NO;
  }else{
    //BT Connected start session
    return YES;

  }
}

// initialize the accessory with the protocolString
- (void)setupControllerForAccessory:(EAAccessory *)accessory withProtocolString:(NSString *)protocolString
{

  _accessory = accessory;

  _protocolString = [protocolString copy];
}

- (EASession *)openSessionForProtocol:(NSString *)protocolString{

  NSArray *accessories = [[EAAccessoryManager sharedAccessoryManager]
  connectedAccessories];
  EAAccessory *accessory = nil;
  for (EAAccessory *obj in accessories) {
    if ([[obj protocolStrings] containsObject:protocolString]){
      accessory = obj;
      break;
    }
  }

  if (accessory){
    _session = [[EASession alloc] initWithAccessory:accessory
    forProtocol:protocolString];
    if (_session) {
      [[_session inputStream] setDelegate:self];
      [[_session inputStream] scheduleInRunLoop:[NSRunLoop currentRunLoop]
      forMode:NSDefaultRunLoopMode];
      [[_session inputStream] open];

      [[_session outputStream] setDelegate:self];
      [[_session outputStream] scheduleInRunLoop:[NSRunLoop currentRunLoop]
      forMode:NSDefaultRunLoopMode];
      [[_session outputStream] open];
    }
  }

  return _session;
}

// close the session with the accessory.
- (void)closeSession
{
  [[_session inputStream] close];
  [[_session inputStream] removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
  [[_session inputStream] setDelegate:nil];
  [[_session outputStream] close];
  [[_session outputStream] removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
  [[_session outputStream] setDelegate:nil];

  _session = nil;
  _writeData = nil;
  _readData = nil;
}

+ (BTConnectionManager *)sharedController
{
  static BTConnectionManager *sessionController = nil;
  if (sessionController == nil) {
    sessionController = [[BTConnectionManager alloc] init];
  }

  return sessionController;
}

- (BOOL)isConnected{
  //check the connection status and return the value
  //to detect if a connection exists

  return NO;
}

#pragma mark stream eventws
// asynchronous NSStream handleEvent method
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
  switch (eventCode) {
    case NSStreamEventNone:
    break;
    case NSStreamEventOpenCompleted:
    break;
    case NSStreamEventHasBytesAvailable:
    [self readReceivedData];
    break;
    case NSStreamEventHasSpaceAvailable:
    //[self _writeData];
    break;
    case NSStreamEventErrorOccurred:
    break;
    case NSStreamEventEndEncountered:
    break;
    default:
    break;
  }
}

-(void)parseDataStream:(NSString *)dataString {

  //parse your data here.


}

@end
