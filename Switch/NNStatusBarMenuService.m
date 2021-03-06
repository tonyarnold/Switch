//
//  NNStatusBarMenuService.m
//  Switch
//
//  Created by Scott Perry on 10/15/13.
//  Copyright © 2013 Scott Perry.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "NNStatusBarMenuService.h"

#import "NNAppDelegate.h"
#import "NNPreferencesService.h"


@interface NNStatusBarMenuService () <NSMenuDelegate, NNPreferencesServiceDelegate>

@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) NSSet *debugItems;

@end


@implementation NNStatusBarMenuService

- (instancetype)init;
{
    if (!(self = [super init])) { return nil; }
    
    NSStatusItem *statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    statusItem.image = [[NSBundle mainBundle] imageForResource:@"weave"];
    statusItem.highlightMode = YES;
    statusItem.target = self;
    
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Status Bar Menu"];
    
    // and set self.menu.menu to a menu (AND RENAME THAT SHIT WHAT THE EVERLOVING FUCK)
    NSMenuItem * menuItem;
    
#   pragma clang diagnostic push
#   pragma clang diagnostic ignored "-Wselector"
    menuItem = [[NSMenuItem alloc] initWithTitle:@"Preferences…" action:@selector(showPreferences:) keyEquivalent:@""];
#   pragma clang diagnostic pop
    menuItem.target = [NSApplication sharedApplication].delegate;
    [menu addItem:menuItem];
    
    [menu addItem:[NSMenuItem separatorItem]];
    
    { // These get filtered out when option is not pressed:
        NSMutableSet *debugItems = [NSMutableSet set];
        
        menuItem = [[NSMenuItem alloc] initWithTitle:@"Hi there!" action:NULL keyEquivalent:@""];
        menuItem.enabled = NO;
        [menu addItem:menuItem];
        [debugItems addObject:menuItem];
        
        menuItem = [[NSMenuItem alloc] initWithTitle:@"Take Snapshot…" action:@selector(snapshot:) keyEquivalent:@""];
        menuItem.target = self;
        [menu addItem:menuItem];
        [debugItems addObject:menuItem];
        
        menuItem = [[NSMenuItem alloc] initWithTitle:@"Open Log Folder…" action:@selector(openLogFolder:) keyEquivalent:@""];
        menuItem.target = self;
        [menu addItem:menuItem];
        [debugItems addObject:menuItem];
        
        menuItem = [NSMenuItem separatorItem];
        [menu addItem:menuItem];
        [debugItems addObject:menuItem];
        
        _debugItems = debugItems;
    }
    
#   pragma clang diagnostic push
#   pragma clang diagnostic ignored "-Wselector"
    menuItem = [[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
#   pragma clang diagnostic pop
    menuItem.target = [NSApplication sharedApplication];
    [menu addItem:menuItem];
    
    menu.delegate = self;
    
    statusItem.menu = menu;
    
    _statusItem = statusItem;
    
    return self;
}

- (NNServiceType)serviceType;
{
    return NNServiceTypePersistent;
}

- (NSSet *)dependencies;
{
    return [NSSet setWithObject:[NNPreferencesService class]];
}

- (void)startService;
{
    [[NNServiceManager sharedManager] addSubscriber:self forService:[NNPreferencesService class]];
}

#pragma mark NNPreferencesServiceDelegate

- (oneway void)preferencesService:(NNPreferencesService *)service didSetValue:(id)value forKey:(NSString *)key;
{
    #pragma message "Use this to enable/disable the status bar item"
}

#pragma mark NNStatusBarMenuService

- (IBAction)snapshot:(id)sender;
{
    [[NNLoggingService sharedService] takeWindowListSnapshot];
    [self openLogFolder:self];
}

- (IBAction)openLogFolder:(id)sender;
{
    [[NSWorkspace sharedWorkspace] openFile:[[NNLoggingService sharedService] logDirectoryPath]];
}

- (void)menuNeedsUpdate:(NSMenu *)menu;
{
    NSUInteger flags = ([NSEvent modifierFlags] & NSDeviceIndependentModifierFlagsMask);
    BOOL hideDebugItems = !(flags == NSAlternateKeyMask);
    
    for (NSMenuItem *item in self.debugItems) {
        item.hidden = hideDebugItems;
    }
}

@end
