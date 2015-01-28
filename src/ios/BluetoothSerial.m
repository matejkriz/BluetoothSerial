//
//  BluetoothSerial.m
//  EADemo
//
//  Created by Matěj Kříž on 27.01.15.
//
//

#import "BluetoothSerial.h"
#import "EADSessionController.h"
#import <Cordova/CDV.h>

@implementation BluetoothSerial



- (void)list:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = @"ahoj";

    EADSessionController* _sessionController = [[EADSessionController alloc] init];
    echo = _sessionController.accessory.name;

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
