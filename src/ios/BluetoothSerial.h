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
}

 - (void)list:(CDVInvokedUrlCommand*)command;
 //- (void)_sessionDataReceived:(NSNotification *)notification;

@end
