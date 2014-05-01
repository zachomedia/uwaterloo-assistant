//
//  AddCourseWindowController.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <uwaterloo-api/Course.h>

@interface AddCourseWindowController : NSWindowController

@property (weak) IBOutlet NSPopUpButton *subjectDropdown;
@property (weak) IBOutlet NSPopUpButton *courseDropdown;
@property (weak) IBOutlet NSButton *addCourseButton;

@property (nonatomic, strong) Course *selectedCourse;

- (id)initWithWindowNibName:(NSString *)windowNibName;

- (IBAction)cancel:(id)sender;
- (IBAction)addCourse:(id)sender;

- (IBAction)subjectSelected:(id)sender;
- (IBAction)courseSelected:(id)sender;
@end
