//
//  NNEventManager.h
//  Switch
//
//  Created by Scott Perry on 02/21/13.
//  Copyright © 2013 Scott Perry.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>


@class NNHotKey;


typedef NS_ENUM(NSUInteger, NNEventManagerEventType) {
    NNEventManagerEventTypeInvoke,
    NNEventManagerEventTypeDismiss,        // You cannot set this, it is bound to the release of all modifiers after a NNEventManagerEventTypeInvoke
    NNEventManagerEventTypeIncrement,      // You cannot set this, it is bound to the same key as NNEventManagerEventTypeInvoke (keyDown)
    NNEventManagerEventTypeEndIncrement,   // You cannot set this, it is bound to the same key as NNEventManagerEventTypeInvoke (keyUp)
    NNEventManagerEventTypeDecrement,
    NNEventManagerEventTypeEndDecrement,   // You cannot set this, it is bound to the same key as NNEventManagerEventTypeDecrement (keyUp)
    NNEventManagerEventTypeCloseWindow,
    NNEventManagerEventTypeCancel,
    NNEventManagerEventTypeShowPreferences,
};

typedef NS_ENUM(NSUInteger, NNEventManagerMouseEventType) {
    NNEventManagerMouseEventTypeMove,
};


extern NSString *NNEventManagerMouseNotificationName;
extern NSString *NNEventManagerKeyNotificationName;
extern NSString *NNEventManagerEventTypeKey;
extern NSString *NNEventManagerEventMouseLocationKey;


@interface NNEventManager : NSObject

+ (NNEventManager *)sharedManager;

- (void)registerHotKey:(NNHotKey *)hotKey forEvent:(NNEventManagerEventType)eventType;

@end
