//
//  PreferencesWindowController.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "PreferencesWindowController.h"

#import "GeneralPreferencesViewController.h"
#import "CoursesPreferencesViewController.h"
#import "AboutViewController.h"

@interface PreferencesWindowController ()

@end

@implementation PreferencesWindowController
{
    NSViewController<PreferencesModifier> *activePrefencesView;
}

-(id)init
{
    self = [super initWithWindowNibName:@"PreferencesWindow"];
    
    return self;
}// End of init

-(id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    
    return self;
}// End of initWithWindow

-(void)windowDidLoad
{
    [super windowDidLoad];
    
    self.tabbar.selectedItemIdentifier = @"generalToolbarItem";
    [self tabSelected:self.generalTab];
}// End of windowDidLoad

-(void)windowWillClose:(NSNotification *)notification
{
    // Hide the Dock icon
    [NSApp setActivationPolicy: NSApplicationActivationPolicyProhibited];
}// End of windowWillClose

-(IBAction)tabSelected:(id)sender
{
    Log(@"Tab Selected");
    
    NSToolbarItem *tab = (NSToolbarItem *)sender;
    
    if (tab == self.generalTab)
    {
        [self.window setTitle:@"General"];
        
        activePrefencesView = [[GeneralPreferencesViewController alloc] initWithNibName:@"GeneralPreferencesView" bundle:nil];
    }// End of if
    else if (tab == self.coursesTab)
    {
        [self.window setTitle:@"Courses"];
        
        activePrefencesView = [[CoursesPreferencesViewController alloc] initWithNibName:@"CoursesPreferencesView" bundle:nil];
    }// End of else if
    else if (tab == self.aboutTab)
    {
        [self.window setTitle:@"About"];
        
        activePrefencesView = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
    }// End of else if
    
    self.window.contentView = activePrefencesView.view;
    [self resizeWindow];
}// End of tabSelected

-(void)resizeWindow
{
    Log(@"Content View Size: %f", [self.window.contentView bounds].size.height);
}

@end
