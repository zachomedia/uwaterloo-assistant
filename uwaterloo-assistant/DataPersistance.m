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
#define START_AT_LOGIN_KEY @"StartAtLogin"

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
        }// End of try
        @catch (NSException *ex)
        {
            Log(@"Exception: %@", ex.description);
        }// End of catch
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

+(BOOL)startAtLogin
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    return [[NSUserDefaults standardUserDefaults] boolForKey:START_AT_LOGIN_KEY];
}// End of startAtLogin

+(void)setStartAtLogin:(BOOL)startAtLogin
{   
    if (startAtLogin)
    {
        Log(@"Adding to startup items...");
        [DataPersistance addAppToLogin];
    }// End of if
    else
    {
        Log(@"Removing from startup items...");
        [DataPersistance removeAppFromLogin];
    }// End of else if
    
    [[NSUserDefaults standardUserDefaults] setBool:startAtLogin forKey:START_AT_LOGIN_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}// End of setStartAtLogin

/* BASED ON: http://cocoatutorial.grapewave.com/tag/lssharedfilelist-h/ */
+(void)addAppToLogin
{
    NSString *appPath = [[NSBundle mainBundle] bundlePath];
    CFURLRef url = (CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:appPath]);
    
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    
    if (loginItems)
    {
        LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(loginItems, kLSSharedFileListItemLast, NULL, NULL, url, NULL, NULL);
        
        if (item)
            CFRelease(item);
        
        CFRelease(loginItems);
    }// End of if
}// End of addAppToLogin

+(void)removeAppFromLogin
{
    NSString *appPath = [[NSBundle mainBundle] bundlePath];
    CFURLRef url = (CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:appPath]);
    
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    
    if (loginItems)
    {
        UInt32 seedValue;
        NSArray *items = (NSArray *)CFBridgingRelease(LSSharedFileListCopySnapshot(loginItems, &seedValue));
        
        for (int x = 0; x < items.count; ++x)
        {
            LSSharedFileListItemRef itemReference = (LSSharedFileListItemRef)CFBridgingRetain([items objectAtIndex:x]);
            
            if (LSSharedFileListItemResolve(itemReference, 0, (CFURLRef *)&url, NULL) == noErr)
            {
                NSString *urlPath = [(NSURL *)CFBridgingRelease(url) path];
                
                if ([urlPath isEqualToString:appPath])
                {
                    LSSharedFileListItemRemove(loginItems, itemReference);
                }// End of if
            }// End of if
        }// End of for
    }// End of if
}// End of removeAppFromLogin

@end
