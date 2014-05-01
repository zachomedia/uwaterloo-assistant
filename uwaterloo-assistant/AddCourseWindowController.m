//
//  AddCourseWindowController.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "AddCourseWindowController.h"

#import <uwaterloo-api/UWaterlooAPI.h>
#import "AppDelegate.h"

@interface AddCourseWindowController ()

@end

@implementation AddCourseWindowController
{
    UWaterlooAPI *api;
    
    NSArray *subjects;
    NSArray *courses;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self)
    {
        
    }// End of if
    return self;
}

- (id)initWithWindowNibName:(NSString *)windowNibName
{
    self = [super initWithWindowNibName:windowNibName];
    
    if (self)
    {
        
    }// End of if
    
    return self;
}// End of initWithNibName

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    api = appDelegate.api;
    
    [self.subjectDropdown removeAllItems];
    [self.subjectDropdown addItemWithTitle:@"Loading subjects..."];
    [self.subjectDropdown setEnabled:NO];
    
    [self.courseDropdown removeAllItems];
    [self.courseDropdown addItemWithTitle:@""];
    [self.courseDropdown setEnabled:NO];
    
    [self.addCourseButton setEnabled:NO];
    
    // Load available subjects
    [api subjectsWithTarget:self successSelector:@selector(subjectsLoaded:) andFailureSelector:@selector(loadError:)];
}// End of windowDidLoad

-(void)subjectsLoaded:(Subjects *)in_subjects
{
    subjects = [[in_subjects.subjects allValues] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        Subject *sub1 = (Subject *)obj1;
        Subject *sub2 = (Subject *)obj2;
        
        return [sub1.code compare:sub2.code];
    }];
    
    [self.subjectDropdown removeAllItems];
    [self.subjectDropdown addItemWithTitle:@"Select a subject..."];
    
    for (Subject *subject in subjects)
    {
        [self.subjectDropdown addItemWithTitle:[NSString stringWithFormat:@"%@ - %@", subject.code, subject.description]];
    }// End of for
    
    [self.subjectDropdown setEnabled:YES];
}

-(void)loadError:(NSError *)error
{
    Log(@"Failed to load: %@", error.description);
    [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseAbort];
}

- (IBAction)subjectSelected:(id)sender
{
    // Load courses for subject
    [self.courseDropdown removeAllItems];
    [self.courseDropdown addItemWithTitle:@"Loading courses..."];
    [self.courseDropdown setEnabled:NO];
    
    NSInteger index = [self.subjectDropdown indexOfSelectedItem] - 1;
    Subject *subject = (Subject *)[subjects objectAtIndex:index];
    
    [api coursesForSubjectCode:subject.code withTarget:self successSelector:@selector(coursesLoaded:) andFailureSelector:@selector(loadError:)];
}// End of subjectSelected

-(void)coursesLoaded:(NSArray *)in_courses
{
    courses = in_courses;
    
    [self.courseDropdown removeAllItems];
    [self.courseDropdown addItemWithTitle:@"Select a course..."];
    
    for (Course *course in courses)
    {
        [self.courseDropdown addItemWithTitle:[NSString stringWithFormat:@"%@ %@ - %@", course.subject, course.catalogNumber, course.title]];
    }// End of for
    
    [self.courseDropdown setEnabled:YES];
}// End of coursesLoaded

- (IBAction)courseSelected:(id)sender
{
    [self.addCourseButton setEnabled:YES];
}// End of courseSelected

- (IBAction)cancel:(id)sender
{
    [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseCancel];
}// End of cancel

- (IBAction)addCourse:(id)sender
{
    NSInteger index = [self.courseDropdown indexOfSelectedItem] - 1;
    self.selectedCourse = (Course *)[courses objectAtIndex:index];
    
    [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseOK];
}// End of addCourse

@end
