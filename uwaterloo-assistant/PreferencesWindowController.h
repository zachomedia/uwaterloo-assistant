//
//  PreferencesWindowController.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "PreferencesModifier.h"

@interface PreferencesWindowController : NSWindowController <NSToolbarDelegate>
{
    NSViewController<PreferencesModifier> *activePrefencesView;
}

@property (weak) IBOutlet NSToolbar *tabbar;
@property (weak) IBOutlet NSToolbarItem *generalTab;
@property (weak) IBOutlet NSToolbarItem *coursesTab;

@property (weak) IBOutlet NSView *preferencesView;

- (IBAction)tabSelected:(id)sender;

@end
