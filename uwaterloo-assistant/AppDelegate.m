//
//  AppDelegate.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-29.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "AppDelegate.h"

#import "APIKey.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    Log(@"Creating Menu...");
    
    api = [[UWaterlooAPI alloc] initWithAPIKey:API_KEY andDelegate:self];
    
    [api termsWithSuccessSelector:@selector(termsReceived:) failureSelector:nil];
    [api weatherWithSuccessSelector:@selector(weatherReceived:) failureSelector:nil];
    
    [self createMenu];
}

-(void)termsReceived:(Terms *)termsReceived
{
    Log("Terms Received!");
    terms = termsReceived;
    [self createMenu];
}// End of requestTerms

-(void)weatherReceived:(Weather *)weatherReceived
{
    Log("Weather Received!");
    weather = weatherReceived;
    [self createMenu];
}// End of requestTerms

#pragma Menu

- (void)createMenu
{
    Log(@"Creating menu...");
    
    NSStatusItem *statusItem = self.statusItem;
    NSMenu *menu;
    
    if (statusItem == nil)
    {
        statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        
        statusItem.title = @"UW";
        statusItem.highlightMode = YES;
        
        menu = [[NSMenu alloc] init];
        statusItem.menu = menu;
    }// End of if
    else
    {
        menu = statusItem.menu;
        [menu removeAllItems];
    }// End of else
    
    // Current Term
    if (terms != nil)
    {
        [menu addItemWithTitle:[NSString stringWithFormat:@"Current Term: %@", terms.currentTerm.name] action:nil keyEquivalent:@""];
    }
    else
    {
        [menu addItemWithTitle:@"Loading current term..." action:nil keyEquivalent:@""];
    }
    
    [menu addItem:[NSMenuItem separatorItem]];
    
    if (weather != nil)
    {
        NSMenuItem *mnuItm = [menu addItemWithTitle:@"Weather" action:nil keyEquivalent:@""];
        NSMenu *submenu = [[NSMenu alloc] init];
        
        [submenu addItemWithTitle:[NSString stringWithFormat:@"Temperature: %@\u00B0C", weather.temperature] action:nil keyEquivalent:@""];
                
        [submenu addItemWithTitle:[NSString stringWithFormat:@"Wind: %@kph at %@\u00B0", weather.windSpeed, weather.windDirection] action:nil keyEquivalent:@""];
        
        [submenu addItem:[NSMenuItem separatorItem]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        [submenu addItemWithTitle:[NSString stringWithFormat:@"Observed: %@", [dateFormatter stringFromDate:weather.observationTime]] action:nil keyEquivalent:@""];
        
        [mnuItm setSubmenu:submenu];
    }
    else
    {
        [menu addItemWithTitle:@"Loading current weather..." action:nil keyEquivalent:@""];
    }
    
    [menu addItem:[NSMenuItem separatorItem]];
    
    // Weather
    
    // Application
    [menu addItemWithTitle:@"Quit uWaterloo Assistant" action:@selector(terminate:) keyEquivalent:@""];

    self.statusItem = statusItem;
}

@end
