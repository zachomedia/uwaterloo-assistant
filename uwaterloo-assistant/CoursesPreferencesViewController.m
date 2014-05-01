//
//  CoursesPreferencesViewController.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "CoursesPreferencesViewController.h"

#import "AddCourseWindowController.h"

#import "AppDelegate.h"

#import <uwaterloo-api/UWaterlooAPI.h>
#import <uwaterloo-api/Subjects.h>

@interface CoursesPreferencesViewController ()

@end

@implementation CoursesPreferencesViewController
{
    NSMutableArray *selectedCourses;
    
    AddCourseWindowController *addCourseWindowController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        selectedCourses = [[NSMutableArray alloc] init];
    }// End of if
    
    return self;
}// End of initWithNibName

-(void)loadView
{
    [super loadView];
    
    [self.selectedCoursesTableview setDataSource:self];
    [self.selectedCoursesTableview setDelegate:self];
    
    [self.removeCourseButton setEnabled:NO];
    
    Log(@"%@", self.selectedCoursesTableview);
}

-(void)savePreferences
{
    Log(@"NOT IMPLEMENTED: Save Courses Preferences");
}// End of savePreferences

- (IBAction)addCourse:(id)sender
{
    addCourseWindowController = [[AddCourseWindowController alloc] initWithWindowNibName:@"AddCourseWindow"];
    
    [self.view.window beginSheet:addCourseWindowController.window completionHandler:^(NSModalResponse returnCode)
    {
        if (returnCode == NSModalResponseOK)
        {
            [selectedCourses addObject:addCourseWindowController.selectedCourse];
            [self.selectedCoursesTableview reloadData];
        }// End of if
        
        addCourseWindowController = nil;
    }];
}// End of addCourse

- (IBAction)removeCourse:(id)sender
{
    NSIndexSet *selected = [self.selectedCoursesTableview selectedRowIndexes];
    [selectedCourses removeObjectsAtIndexes:selected];
    
    [self.selectedCoursesTableview reloadData];
    [self.removeCourseButton setEnabled:NO];
}// End of removeCourse

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    Log(@"Number of Rows: %zd", [selectedCourses count]);
    return [selectedCourses count];
}// End of numberOfRowsInTableView

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Log(@"Loading view...");
    NSTextField *field = [tableView makeViewWithIdentifier:@"CourseField" owner:self];
    
    if (field == nil)
    {
        field = [[NSTextField alloc] init];
        field.identifier = @"CourseField";
        
        [field setBordered:NO];
        [field setEditable:NO];
        [field setBackgroundColor:[NSColor colorWithWhite:1.0 alpha:0.0]];
    }// End of if

    Course *course = (Course *)[selectedCourses objectAtIndex:row];
    
    if (tableColumn == self.courseCodeColumn)
    {
        field.stringValue = [NSString stringWithFormat:@"%@ %@", course.subject, course.catalogNumber];
    }
    else if (tableColumn == self.courseNameColumn)
    {
        field.stringValue = course.title;
    }
    else if (tableColumn == self.sectionColumn)
    {
        field.stringValue = @"Not Implemented";
    }
    
    return field;
}// End of tableView viewForTableColumn row

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSInteger selectedCount = [[self.selectedCoursesTableview selectedRowIndexes] count];
    if (selectedCount == 0)
    {
        [self.removeCourseButton setTitle:@"Remove Courses"];
        [self.removeCourseButton setEnabled:NO];
    }// End of if
    else if (selectedCount == 1)
    {
        [self.removeCourseButton setTitle:@"Remove Course"];
        [self.removeCourseButton setEnabled:YES];
    }
    else
    {
        [self.removeCourseButton setTitle:@"Remove Courses"];
        [self.removeCourseButton setEnabled:YES];
    }// End of else
}// End of tableViewSelectionDidChange

@end
