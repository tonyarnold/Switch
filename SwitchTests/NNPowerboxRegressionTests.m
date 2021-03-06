//
//  NNPowerboxRegressionTests.m
//  Switch
//
//  Created by Scott Perry on 10/11/13.
//  Copyright © 2013 Scott Perry.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  This file tests for regressions concerning Powerbox:
//  * https://github.com/numist/Switch/issues/10
//

#import <XCTest/XCTest.h>

#import "NNWindowFilteringTests.h"


@interface NNPowerboxRegressionTests : XCTestCase

@end


@implementation NNPowerboxRegressionTests

- (void)testPowerboxSaveDialog
{
    NSOrderedSet *windows = [NSOrderedSet orderedSetWithArray:@[
        [NNWindow windowWithDescription:@{
            NNWindowAlpha : @1,
            NNWindowBounds : DICT_FROM_RECT(((CGRect){
                .size.height = 58,
                .size.width = 423,
                .origin.x = 256,
                .origin.y = 255
            })),
            NNWindowIsOnscreen : @1,
            NNWindowLayer : @0,
            NNWindowMemoryUsage : @21788,
            NNWindowName : @"",
            NNWindowNumber : @33264,
            NNWindowOwnerName : @"TextEdit",
            NNWindowOwnerPID : @75652,
            NNWindowSharingState : @1,
            NNWindowStoreType : @2,
        }],
        [NNWindow windowWithDescription:@{
            NNWindowAlpha : @(0.8500000238418579),
            NNWindowBounds : DICT_FROM_RECT(((CGRect){
                .size.height = 10,
                .size.width = 478,
                .origin.x = 229,
                .origin.y = 69
            })),
            NNWindowIsOnscreen : @1,
            NNWindowLayer : @0,
            NNWindowMemoryUsage : @5404,
            NNWindowNumber : @33270,
            NNWindowOwnerName : @"TextEdit",
            NNWindowOwnerPID : @75652,
            NNWindowSharingState : @1,
            NNWindowStoreType : @2,
        }],
        [NNWindow windowWithDescription:@{
            NNWindowAlpha : @1,
            NNWindowBounds : DICT_FROM_RECT(((CGRect){
                .size.height = 293,
                .size.width = 465,
                .origin.x = 235,
                .origin.y = 69
            })),
            NNWindowIsOnscreen : @1,
            NNWindowLayer : @0,
            NNWindowMemoryUsage : @220020,
            NNWindowName : @"Save",
            NNWindowNumber : @33265,
            NNWindowOwnerName : @"com.apple.security.pboxd",
            NNWindowOwnerPID : @75654,
            NNWindowSharingState : @1,
            NNWindowStoreType : @2,
        }],
        [NNWindow windowWithDescription:@{
            NNWindowAlpha : @1,
            NNWindowBounds : DICT_FROM_RECT(((CGRect){
                .size.height = 412,
                .size.width = 640,
                .origin.x = 147,
                .origin.y = 47
            })),
            NNWindowIsOnscreen : @1,
            NNWindowLayer : @0,
            NNWindowMemoryUsage : @1110708,
            NNWindowName : @"Untitled.txt",
            NNWindowNumber : @33261,
            NNWindowOwnerName : @"TextEdit",
            NNWindowOwnerPID : @75652,
            NNWindowSharingState : @1,
            NNWindowStoreType : @2,
        }],
    ]];
    NSOrderedSet *filtered = [NSOrderedSet orderedSetWithObject:windows[3]];
    
    XCTAssertEqualObjects(filtered, [NNWindow filterInvalidWindowsFromSet:windows], @"Powerbox window and related sheet windows were not filtered out correctly");
}

@end
