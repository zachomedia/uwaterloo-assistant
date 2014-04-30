//
//  AboutViewController.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

-(void)savePreferences
{
    // does nothing
    // only an about page
}

- (IBAction)viewOnGithub:(id)sender
{
    NSURL *url = [[NSURL alloc] initWithString:@"https://github.com/zachomedia/uwaterloo-assistant/"];
    [[NSWorkspace sharedWorkspace] openURL:url];
}// End of viewOnGithub

@end
