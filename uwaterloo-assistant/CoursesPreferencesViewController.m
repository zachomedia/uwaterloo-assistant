//
//  CoursesPreferencesViewController.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "CoursesPreferencesViewController.h"

#import "AddCourseWindowController.h"

#import "DataPersistance.h"

#import <uwaterloo-api/UWaterlooAPI.h>

@interface CoursesPreferencesViewController ()

@end

@implementation CoursesPreferencesViewController
{
    NSMutableArray *selectedSections;
    
    AddCourseWindowController *addCourseWindowController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        selectedSections = [[NSMutableArray alloc] initWithArray:[DataPersistance userSections]];
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
    Log(@"Saving Courses Preferences...");
    
    [DataPersistance setUserSections:selectedSections];
}// End of savePreferences

- (IBAction)addCourse:(id)sender
{
    addCourseWindowController = [[AddCourseWindowController alloc] initWithWindowNibName:@"AddCourseWindow"];
    
    [self.view.window beginSheet:addCourseWindowController.window completionHandler:^(NSModalResponse returnCode)
    {
        if (returnCode == NSModalResponseOK)
        {
            [selectedSections addObject:addCourseWindowController.selectedSection];
            [self.selectedCoursesTableview reloadData];
        }// End of if
        
        addCourseWindowController = nil;
        [self savePreferences];
    }];
}// End of addCourse

- (IBAction)removeCourse:(id)sender
{
    NSIndexSet *selected = [self.selectedCoursesTableview selectedRowIndexes];
    [selectedSections removeObjectsAtIndexes:selected];
    
    [self savePreferences];
    
    [self.selectedCoursesTableview reloadData];
    [self.removeCourseButton setEnabled:NO];
}// End of removeCourse

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    Log(@"Number of Rows: %zd", [selectedSections count]);
    return [selectedSections count];
}// End of numberOfRowsInTableView

-(NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTextFieldCell *field = [tableColumn dataCell];
    [field setEditable:NO];
    
    return field;
}// End of tableView dataCellForTableColumn row

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Section *section = (Section *)[selectedSections objectAtIndex:row];
    
    if (tableColumn == self.courseCodeColumn)
    {
        return [NSString stringWithFormat:@"%@ %@", section.subject, section.catalogNumber];
    }// End of if
    else if (tableColumn == self.courseNameColumn)
    {
        return section.title;
    }// End of else if
    else
    {
        return section.section;
    }// End of else
}// End of tableView objectValueForTableColumn

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
