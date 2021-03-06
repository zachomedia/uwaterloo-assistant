//
//  AppDelegate.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-29.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "AppDelegate.h"

#import "APIKey.h"
#import "DataPersistance.h"

@implementation AppDelegate
{
    Terms *terms;
    Weather *weather;
    
    NSMenuItem *termMenuItem;
    NSMenuItem *weatherMenuItem;
    NSMenuItem *coursesMenuItem;
    
    NSTimer *shortRefreshTimer;
    NSTimer *longRefreshTimer;
    
    NSArray *userSections;
    
    PreferencesWindowController *preferencesWindowController;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    Log(@"Creating Menu...");
    
    // Hide the Dock icon
    [NSApp setActivationPolicy: NSApplicationActivationPolicyProhibited];
    
    // Register for updates to NSUserDefaults
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultsChanged:) name:NSUserDefaultsDidChangeNotification object:nil];
    
    // Load stored data
    userSections = [DataPersistance userSections];
    
    // Initalize the API
    self.api = [[UWaterlooAPI alloc] initWithAPIKey:API_KEY];
    
    // Setup update timers
    shortRefreshTimer = [NSTimer scheduledTimerWithTimeInterval:(30 * 60) target:self selector:@selector(shortRefreshTimerTick) userInfo:nil repeats:YES];
    
    longRefreshTimer = [NSTimer scheduledTimerWithTimeInterval:(2 * 3600) target:self selector:@selector(longRefreshTimerTick) userInfo:nil repeats:YES];
    
    [self requestAPIData];
    [self createMenu];
}// End of applicationDidFinishLaunching

-(void)defaultsChanged:(NSNotification *)notification
{
    userSections = [DataPersistance userSections];
    [self updateCoursesMenuItem];
}// End of defaultsChanged

-(void)shortRefreshTimerTick
{
    Log(@"Short Refresh Timer Tick");
    [self.api weatherWithTarget:self successSelector:@selector(weatherReceived:) andFailureSelector:@selector(weatherFailed:)];
}// End of shortRefreshTimerTick

-(void)longRefreshTimerTick
{
    Log(@"Long Refresh Timer Tick");
    [self.api termsWithTarget:self successSelector:@selector(termsReceived:) andFailureSelector:@selector(termsFailed:)];
}// End of longRefreshTimerTick

-(void)requestAPIData
{
    [shortRefreshTimer fire];
    [longRefreshTimer fire];
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
    
    coursesMenuItem = [menu addItemWithTitle:@"Loading courses..." action:nil keyEquivalent:@""];
    [self updateCoursesMenuItem];
    
    [menu addItem:[NSMenuItem separatorItem]];
    
    weatherMenuItem = [menu addItemWithTitle:@"Loading weather information..." action:nil keyEquivalent:@""];
    
    [menu addItem:[NSMenuItem separatorItem]];
    
    // Links
    [menu addItemWithTitle:@"Open Learn..." action:@selector(openLearn) keyEquivalent:@""];
    [menu addItemWithTitle:@"Open Quest..." action:@selector(openQuest) keyEquivalent:@""];
    
    [menu addItem:[NSMenuItem separatorItem]];
    
    // App Actions
    [menu addItemWithTitle:@"Refresh Data" action:@selector(requestAPIData) keyEquivalent:@""];
    [menu addItemWithTitle:@"Preferences..." action:@selector(showPreferences:) keyEquivalent:@""];
    
    [menu addItem:[NSMenuItem separatorItem]];
    
    [menu addItemWithTitle:@"Quit uWaterloo Assistant" action:@selector(terminate:) keyEquivalent:@""];
}// End of createMenu

-(void)openLearn
{
    NSURL *url = [[NSURL alloc] initWithString:@"https://learn.uwaterloo.ca/"];
    [[NSWorkspace sharedWorkspace] openURL:url];
}// End of openLearn

-(void)openQuest
{
    NSURL *url = [[NSURL alloc] initWithString:@"https://quest.pecs.uwaterloo.ca/psp/SS?cmd=login"];
    [[NSWorkspace sharedWorkspace] openURL:url];
}// End of openLearn

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
        weatherMenuItem.submenu = nil;
        [weatherMenuItem setEnabled:NO];
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
        [weatherMenuItem setEnabled:YES];
    }// End of else
}// End of updateWeatherMenuItem

-(void)updateCoursesMenuItem
{
    Log(@"Updating courses menu item");
    
    if (userSections == nil)
    {
        coursesMenuItem.title = @"Courses Information Unavailable";
        [coursesMenuItem.submenu removeAllItems];
    }// End of if
    else
    {
        NSMenu *menu = coursesMenuItem.submenu;
        if (menu == nil)
        {
            menu = [[NSMenu alloc] init];
            coursesMenuItem.submenu = menu;
        }// End of if
        [menu removeAllItems];
        
        for (Section *section in userSections)
        {
            NSMenu *submenu = [[NSMenu alloc] init];
            
            [submenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@ - %@", section.subject, section.catalogNumber, section.section] action:nil keyEquivalent:@""];
            [submenu addItemWithTitle:section.title action:nil keyEquivalent:@""];
            
            [submenu addItem:[NSMenuItem separatorItem]];
            
            NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
            [timeFormatter setDateStyle:NSDateFormatterNoStyle];
            [timeFormatter setTimeStyle:NSDateFormatterShortStyle];
            
            for (NSInteger x = 0; x < section.sessions.count; ++x)
            {
                Session *session = [section.sessions objectAtIndex:x];
                
                if (session.cancelled)
                {
                    [submenu addItemWithTitle:@"Cancelled" action:nil keyEquivalent:@""];
                }// End of if
                else if (session.toBeAnnounced)
                {
                    [submenu addItemWithTitle:@"To Be Announced" action:nil keyEquivalent:@""];
                }// End of else if
                else
                {
                    NSString *weekdays = @"";
                    
                    for (NSValue *vweekday in session.weekdays)
                    {
                        Weekday weekday;
                        NSString *strWeekday = @"";
                        
                        [vweekday getValue:&weekday];
                        
                        switch (weekday)
                        {
                            case WeekdaySunday:
                                strWeekday = @"Sunday";
                                break;
                                
                            case WeekdayMonday:
                                strWeekday = @"Monday";
                                break;
                                
                            case WeekdayTuesday:
                                strWeekday = @"Tuesday";
                                break;
                                
                            case WeekdayWednesday:
                                strWeekday = @"Wednesday";
                                break;
                                
                            case WeekdayThursday:
                                strWeekday = @"Thursday";
                                break;
                                
                            case WeekdayFriday:
                                strWeekday = @"Friday";
                                break;
                                
                            case WeekdaySaturday:
                                strWeekday = @"Saturday";
                                break;
                        }// End of swtich
                        
                        if (weekdays.length > 0)
                        {
                            weekdays = [weekdays stringByAppendingString:@", "];
                        }// End of if
                        
                        weekdays = [weekdays stringByAppendingFormat:@"%@", strWeekday];
                    }// End of weekday
                    
                    [submenu addItemWithTitle:weekdays action:nil keyEquivalent:@""];
                    
                    [submenu addItemWithTitle:[NSString stringWithFormat:@"%@ - %@", [timeFormatter stringFromDate:session.startTime], [timeFormatter stringFromDate:session.endTime]] action:nil keyEquivalent:@""];
                    
                    [submenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", session.building, session.room] action:nil keyEquivalent:@""];

                }// End of else
                
                
                if (x != section.sessions.count - 1)
                {
                    [submenu addItemWithTitle:@"" action:nil keyEquivalent:@""];
                }// End of if
            }// End of for
            
            NSMenuItem *itm = [menu addItemWithTitle:[NSString stringWithFormat:@"%@ %@ - %@", section.subject, section.catalogNumber, section.section] action:nil keyEquivalent:@""];
            itm.submenu = submenu;
        }// End of for
        
        if ([userSections count] == 0)
        {
            [menu addItemWithTitle:@"Add courses in preferences..." action:@selector(showPreferences:) keyEquivalent:@""];
        }// End of if
        
        coursesMenuItem.title = @"Courses";
    }// End of else
}// End of updateCoursesMenuItem

@end
