//
//  BluetoothSerial.h
//  EADemo
//
//  Created by Matěj Kříž on 27.01.15.
//
//

#import <UIKit/UIKit.h>
#import <Cordova/CDV.h>

#import "EADSessionController.h"

@interface BluetoothSerial : CDVPlugin
{
    NSMutableArray *_accessoryList;
    EADSessionController *_eaSessionController;
    NSString *_subscribeCallbackId;
    NSString *_delimiter;
    NSObject *_dataReceivedObserver;
}

 - (void)connect:(CDVInvokedUrlCommand*)command;
 - (void)disconnect:(CDVInvokedUrlCommand*)command;
 - (void)list:(CDVInvokedUrlCommand*)command;
 - (void)pair:(CDVInvokedUrlCommand*)command;
 - (void)isEnabled:(CDVInvokedUrlCommand*)command;
 - (void)isConnected:(CDVInvokedUrlCommand*)command;
 - (void)available:(CDVInvokedUrlCommand*)command;
 - (void)read:(CDVInvokedUrlCommand*)command;
 - (void)readUntil:(CDVInvokedUrlCommand*)command;
 - (void)write:(CDVInvokedUrlCommand*)command;
 - (void)subscribe:(CDVInvokedUrlCommand*)command;
 - (void)unsubscribe:(CDVInvokedUrlCommand*)command;
 - (void)clear:(CDVInvokedUrlCommand*)command;

@end
