//
//  NNAXAPIService.m
//  Switch
//
//  Created by Scott Perry on 10/20/13.
//  Copyright © 2013 Scott Perry.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "NNAXAPIService.h"

#import "NNAPIEnabledWorker.h"


@interface NNAXAPIService ()

@property (nonatomic, strong) NNAPIEnabledWorker *worker;

@end


@implementation NNAXAPIService

- (NNServiceType)serviceType;
{
    return NNServiceTypePersistent;
}

- (void)startService;
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessibilityAPIDisabled:) name:NNAXAPIDisabledNotification object:nil];
    
    if (![NNAPIEnabledWorker isAPIEnabled]) {
        [self accessibilityAPIDisabled:nil];
    }
}

- (void)stopService;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NNAXAPIDisabledNotification object:nil];
}

- (void)accessibilityAPIDisabled:(NSNotification *)note;
{
    self.worker = [NNAPIEnabledWorker new];
    
    AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)@{ (__bridge NSString *)kAXTrustedCheckOptionPrompt : @YES });
}

- (void)accessibilityAPIAvailabilityChangedNotification:(NSNotification *)notification;
{
    BOOL accessibilityEnabled = [notification.userInfo[NNAXAPIEnabledKey] boolValue];
    
    NNLog(@"Accessibility API is %@abled", accessibilityEnabled ? @"en" : @"dis");
    
    if (!accessibilityEnabled) {
        self.worker = nil;
    }
}

- (void)setWorker:(NNAPIEnabledWorker *)worker;
{
    if (worker == _worker) {
        return;
    }
    if (_worker) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NNAPIEnabledWorker.notificationName object:_worker];
    }
    if (worker) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessibilityAPIAvailabilityChangedNotification:) name:NNAPIEnabledWorker.notificationName object:self.worker];
    }
    _worker = worker;
}

@end
