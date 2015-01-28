//
//  BluetoothSerial.h
//  EADemo
//
//  Created by Matěj Kříž on 27.01.15.
//
//

#import <UIKit/UIKit.h>
#import <Cordova/CDV.h>

@interface BluetoothSerial : CDVPlugin

 - (void)list:(CDVInvokedUrlCommand*)command;

@end
