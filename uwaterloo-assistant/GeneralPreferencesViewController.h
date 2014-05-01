//
//  GeneralPreferencesViewController.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "PreferencesModifier.h"

@interface GeneralPreferencesViewController : NSViewController<PreferencesModifier>

@property (weak) IBOutlet NSButton *startAtLoginCheckbox;

- (IBAction)toggleStartAtLogin:(id)sender;

@end
