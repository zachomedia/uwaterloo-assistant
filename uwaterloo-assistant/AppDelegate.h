//
//  AppDelegate.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-29.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <uwaterloo-api/UWaterlooAPI.h>
#import "PreferencesWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

- (IBAction)showPreferences:(id)sender;

@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSStatusItem *statusItem;

@property (strong, nonatomic) UWaterlooAPI *api;

@end
