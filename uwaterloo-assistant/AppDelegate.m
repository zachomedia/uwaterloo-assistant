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
    
    [NSApp setActivationPolicy: NSApplicationActivationPolicyProhibited];
    
    api = [[UWaterlooAPI alloc] initWithAPIKey:API_KEY andDelegate:self];
    
    [self requestAPIData];
    [self createMenu];
}

-(void)requestAPIData
{
    [api termsWithSuccessSelector:@selector(termsReceived:) failureSelector:@selector(termsFailed:)];
    [api weatherWithSuccessSelector:@selector(weatherReceived:) failureSelector:@selector(weatherFailed:)];
}// End of requestAPIData

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
    [menu addItemWithTitle:@"Preferences... (Coming Soon)" action:nil keyEquivalent:@""];
    
    [menu addItem:[NSMenuItem separatorItem]];
    
    [menu addItemWithTitle:@"Quit uWaterloo Assistant" action:@selector(terminate:) keyEquivalent:@""];
}// End of createMenu

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
        termMenuItem.title = [NSString stringWithFormat:@"Current Term: %@", terms.currentTerm.name];
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
