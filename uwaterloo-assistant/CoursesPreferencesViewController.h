//
//  CoursesPreferencesViewController.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "PreferencesModifier.h"

@interface CoursesPreferencesViewController : NSViewController<PreferencesModifier,  NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *selectedCoursesTableview;
@property (weak) IBOutlet NSTableColumn *courseCodeColumn;
@property (weak) IBOutlet NSTableColumn *courseNameColumn;
@property (weak) IBOutlet NSTableColumn *sectionColumn;

@property (weak) IBOutlet NSButton *addCourseButton;
@property (weak) IBOutlet NSButton *removeCourseButton;

- (IBAction)addCourse:(id)sender;
- (IBAction)removeCourse:(id)sender;

@end
