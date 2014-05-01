//
//  DataPersistance.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-05-01.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "DataPersistance.h"

#import "uwaterloo-api/Section.h"

#define USER_SECTIONS_KEY @"UserSections"

@implementation DataPersistance

+(NSArray *)userSections
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSArray *encodedCourses = [[NSUserDefaults standardUserDefaults] arrayForKey:USER_SECTIONS_KEY];
    
    if (encodedCourses == nil)
    {
        return [[NSArray alloc] init];
    }// End of if
    
    NSMutableArray *mcourses = [[NSMutableArray alloc] init];
    
    Log(@"Decoding %zd sections.", [encodedCourses count]);
    
    for (NSData *encoded in encodedCourses)
    {
        @try
        {
            Section *section = [NSKeyedUnarchiver unarchiveObjectWithData:encoded];
            [mcourses addObject:section];
        }
        @catch (NSException *ex)
        {
            Log(@"Exception: %@", ex.description);
        }
    }// End of for
    
    Log(@"Decoded %zd sections.", [mcourses count]);
    
    return [[NSArray alloc] initWithArray:mcourses];
}// End of userCourses

+(void)setUserSections:(NSArray *)sections
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSMutableArray *encodedCourses = [[NSMutableArray alloc] init];
    
    for (Section *section in sections)
    {
        [encodedCourses addObject:[NSKeyedArchiver archivedDataWithRootObject:section]];
    }// End of for
    
    [[NSUserDefaults standardUserDefaults] setObject:[[NSArray alloc] initWithArray:encodedCourses] forKey:USER_SECTIONS_KEY];
}// End of setUserCourses

@end
