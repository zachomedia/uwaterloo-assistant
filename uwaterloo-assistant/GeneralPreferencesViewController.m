//
//  GeneralPreferencesViewController.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "GeneralPreferencesViewController.h"

#import "DataPersistance.h"

@interface GeneralPreferencesViewController ()

@end

@implementation GeneralPreferencesViewController
{
    BOOL startAtLogin;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}// End of initWithNibName

-(void)loadView
{
    [super loadView];
    
    startAtLogin = [DataPersistance startAtLogin];
    if (startAtLogin)
        self.startAtLoginCheckbox.state = NSOnState;
}// End of loadView

-(void)savePreferences
{
    [DataPersistance setStartAtLogin:startAtLogin];
}// End of savePreferences

- (IBAction)toggleStartAtLogin:(id)sender
{
    startAtLogin = self.startAtLoginCheckbox.state == NSOnState;
    NSLog(@"Checked: %i", startAtLogin);
    [self savePreferences];
}// End of toggleStartAtLogin
@end
