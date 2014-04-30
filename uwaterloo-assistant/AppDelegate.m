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
{
    UWaterlooAPI *api;
    
    Terms *terms;
    Weather *weather;
    
    NSMenuItem *termMenuItem;
    NSMenuItem *weatherMenuItem;
    
    NSTimer *shortRefreshTimer;
    NSTimer *longRefreshTimer;
    
    PreferencesWindowController *preferencesWindowController;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    Log(@"Creating Menu...");
    
    // Hide the Dock icon
    [NSApp setActivationPolicy: NSApplicationActivationPolicyProhibited];
    
    // Initalize the API
    api = [[UWaterlooAPI alloc] initWithAPIKey:API_KEY andDelegate:self];
    
    // Setup update timers
    shortRefreshTimer = [NSTimer scheduledTimerWithTimeInterval:(30 * 60) target:self selector:@selector(shortRefreshTimerTick) userInfo:nil repeats:YES];
    
    longRefreshTimer = [NSTimer scheduledTimerWithTimeInterval:(2 * 3600) target:self selector:@selector(longRefreshTimerTick) userInfo:nil repeats:YES];
    
    [shortRefreshTimer fire];
    [longRefreshTimer fire];
    
    [self createMenu];
}// End of applicationDidFinishLaunching

-(void)shortRefreshTimerTick
{
    Log(@"Short Refresh Timer Tick");
    [api weatherWithSuccessSelector:@selector(weatherReceived:) failureSelector:@selector(weatherFailed:)];
}// End of shortRefreshTimerTick

-(void)longRefreshTimerTick
{
    Log(@"Long Refresh Timer Tick");
    [api termsWithSuccessSelector:@selector(termsReceived:) failureSelector:@selector(termsFailed:)];
}// End of longRefreshTimerTick

#pragma Data Received/Failed selectors

-(void)termsReceived:(Terms *)termsReceived
{
    Log("Terms Received");
    terms = termsReceived;
    
    [self updateTermMenuItem];
}// End of termsReceived

-(void)termsFailed:(NSError *)error
{
    Log("Terms Failed");
    
    terms = nil;
    [self updateTermMenuItem];
}// End of termsFailed

-(void)weatherReceived:(Weather *)weatherReceived
{
    Log("Weather Received");
    
    weather = weatherReceived;
    [self updateWeatherMenuItem];
}// End of weatherReceived

-(void)weatherFailed:(NSError *)error
{
    Log("Weather Failed");
    
    weather = nil;
    [self updateWeatherMenuItem];
}// End of weatherFailed

#pragma Menu

-(void)createMenu
{
    Log(@"Creating Menu");
    
    if (self.statusItem != nil)
    {
        Log(@"Menu has already been created. This method cannot be called multiple times.");
        return;
    }// End of if
    
    self.statusItem = [[NSStatusItem alloc] init];
    NSMenu *menu = [[NSMenu alloc] init];
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    // Configure menu bar
    self.statusItem.title = @"";
    self.statusItem.image = [NSImage imageNamed:@"MenuBarIcon"];
    self.statusItem.alternateImage = [NSImage imageNamed:@"MenuBarIconSelected"];
    self.statusItem.highlightMode = YES;
    self.statusItem.menu = menu;
    
    // Create menu items
    termMenuItem = [menu addItemWithTitle:@"Loading term information..." action:nil keyEquivalent:@""];
    
    [menu addItem:[NSMenuItem separatorItem]];
    
    weatherMenuItem = [menu addItemWithTitle:@"Loading weather information..." action:nil keyEquivalent:@""];
    
    [menu addItem:[NSMenuItem separatorItem]];
    
    [menu addItemWithTitle:@"Refresh Data" action:@selector(requestAPIData) keyEquivalent:@""];
    [menu addItemWithTitle:@"Preferences..." action:@selector(showPreferences:) keyEquivalent:@""];
    
    [menu addItem:[NSMenuItem separatorItem]];
    
    [menu addItemWithTitle:@"Quit uWaterloo Assistant" action:@selector(terminate:) keyEquivalent:@""];
}// End of createMenu

-(IBAction)showPreferences:(id)sender
{
    [NSApp setActivationPolicy: NSApplicationActivationPolicyRegular];
    
    if (preferencesWindowController == nil)
        preferencesWindowController = [[PreferencesWindowController alloc] init];
    
    [NSApp activateIgnoringOtherApps:YES];
    [preferencesWindowController showWindow:self];
}// End of showPreferences

#pragma Update Menu Items

-(void)updateTermMenuItem
{
    Log(@"Updating term menu item");
    
    if (terms == nil)
    {
        termMenuItem.title = @"Term Information Unavailable";
    }// End of if
    else
    {
        termMenuItem.title = [NSString stringWithFormat:@"Term: %@", terms.currentTerm.name];
    }// End of else
}// End of updateTermMenuItem

-(void)updateWeatherMenuItem
{
    Log(@"Updating weather menu item");
    
    if (weather == nil)
    {
        weatherMenuItem.title = @"Weather Information Unavailable";
        [weatherMenuItem.submenu removeAllItems];
    }// End of if
    else
    {
        NSMenu *menu = weatherMenuItem.submenu;
        if (menu == nil)
        {
            menu = [[NSMenu alloc] init];
            weatherMenuItem.submenu = menu;
        }// End of if
        [menu removeAllItems];
        
        [menu addItemWithTitle:[NSString stringWithFormat:@"Temperature: %.1f\u00B0C", [weather.temperature doubleValue]] action:nil keyEquivalent:@""];
        
        if (weather.humidex != nil)
            [menu addItemWithTitle:[NSString stringWithFormat:@"Humidex: %.1f\u00B0C", [weather.humidex doubleValue]] action:nil keyEquivalent:@""];
        
        if (weather.windchill != nil)
            [menu addItemWithTitle:[NSString stringWithFormat:@"Windchill: %.1f\u00B0C", [weather.humidex doubleValue]] action:nil keyEquivalent:@""];
        
        [menu addItem:[NSMenuItem separatorItem]];
        
        [menu addItemWithTitle:[NSString stringWithFormat:@"Wind: %.1fkph at %@\u00B0", [weather.windSpeed doubleValue], weather.windDirection] action:nil keyEquivalent:@""];
        
        [menu addItem:[NSMenuItem separatorItem]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        [menu addItemWithTitle:[NSString stringWithFormat:@"Observed: %@", [dateFormatter stringFromDate:weather.observationTime]] action:nil keyEquivalent:@""];
        
        weatherMenuItem.title = @"Weather";
    }// End of else
}// End of updateWeatherMenuItem

@end
