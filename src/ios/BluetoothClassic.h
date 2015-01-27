//
//  Created by Nathan Stryker on 6/10/14.
//  Copyright (c) 2014 Nathan Stryker. All rights reserved.
//
//  Modified by Matej Kriz
//

#import <UIKit/UIKit.h>
#import <ExternalAccessory/ExternalAccessory.h>

@interface BluetoothClassic()

@property (nonatomic, strong) NSString *messageString;
@property (nonatomic, strong) NSString *buffer;
@property (nonatomic, strong) NSMutableArray *messageArray;
@property (nonatomic, readonly) NSString *protocolString;

@property (strong, nonatomic) NSMutableArray *peripherals;

- (BOOL)openSession;
- (void)closeSession;
- (BOOL)isConnected;

@end
