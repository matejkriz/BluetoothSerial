//
//  BluetoothSerial.m
//  EADemo
//
//  Created by Matěj Kříž on 27.01.15.
//
//

#import "BluetoothSerial.h"
#import <Cordova/CDV.h>

@implementation BluetoothSerial

- (void)list:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:16];

    _eaSessionController = [EADSessionController sharedController];
    [_eaSessionController openSession];
    _accessoryList = [[NSMutableArray alloc] initWithArray:[[EAAccessoryManager sharedAccessoryManager] connectedAccessories]];
    NSLog(@"Ahoj svete!");
    NSLog(@"%@", _accessoryList);

    [result addObject:_accessoryList];
    NSLog(@"%@", result);
//    if ([_accessoryList count] == 0) {
//      result = @"no acsr!";
//    } else if ([_accessoryList count] > 0) {
//      result = [_accessoryList objectAtIndex: 0];
//    } else {
//      result = @"Some error...";
//    }

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsMultipart:result];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

// - (void)_sessionDataReceived:(NSNotification *)notification
// {
//     CDVPluginResult* pluginResult = nil;
//     EADSessionController *sessionController = (EADSessionController *)[notification object];
//     uint32_t bytesAvailable = 0;
//
//     while ((bytesAvailable = [sessionController readBytesAvailable]) > 0) {
//         NSData *data = [sessionController readData:bytesAvailable];
//         if (data) {
//             _totalBytesRead += bytesAvailable;
//         }
//     }
//     NSString* echo = [NSString stringWithFormat: @"%d", _totalBytesRead];
//     pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
//     [_receivedBytesLabel setText:[NSString stringWithFormat:@"Bytes Received from Session: %d", _totalBytesRead]];
// }

@end
