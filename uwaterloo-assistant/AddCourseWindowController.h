//
//  AddCourseWindowController.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <uwaterloo-api/Section.h>

@interface AddCourseWindowController : NSWindowController

@property (weak) IBOutlet NSPopUpButton *subjectDropdown;
@property (weak) IBOutlet NSPopUpButton *courseDropdown;
@property (weak) IBOutlet NSPopUpButton *sectionDropdown;
@property (weak) IBOutlet NSButton *addCourseButton;

@property (nonatomic, strong) Section *selectedSection;

- (id)initWithWindowNibName:(NSString *)windowNibName;

- (IBAction)cancel:(id)sender;
- (IBAction)addCourse:(id)sender;

- (IBAction)subjectSelected:(id)sender;
- (IBAction)courseSelected:(id)sender;
- (IBAction)sectionSeleted:(id)sender;
@end
