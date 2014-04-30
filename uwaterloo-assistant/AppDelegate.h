//
//  AppDelegate.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-29.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <uwaterloo-api/UWaterlooAPI.h>
#import <uwaterloo-api/Terms.h>
#import <uwaterloo-api/Weather.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    UWaterlooAPI *api;
    
    Terms *terms;
    Weather *weather;
    
    NSMenuItem *termMenuItem;
    NSMenuItem *weatherMenuItem;
}

@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSStatusItem *statusItem;

@end
