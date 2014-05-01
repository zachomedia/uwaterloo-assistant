//
//  Session.m
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-05-01.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "Session.h"

#import "JSONUtils.h"

@implementation Session

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"HH:mm"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDictionary *date = [JSONUtils jsonValueOrNil:dictionary forKey:@"date"];
        
        self.startTime = [timeFormatter dateFromString:[JSONUtils jsonValueOrNil:date forKey:@"start_time"]];
        self.endTime = [timeFormatter dateFromString:[JSONUtils jsonValueOrNil:date forKey:@"end_time"]];
        
        NSRegularExpression *weekdaysRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Z][a-z]*" options:0 error:nil];
        
        NSString *stringWeekdays = [JSONUtils jsonValueOrNil:date forKey:@"weekdays"];
        NSArray *stringWeekdaysMatches = [[NSArray alloc] init];
        
        if (stringWeekdays != nil)
        {
            stringWeekdaysMatches = [weekdaysRegularExpression matchesInString:stringWeekdays options:0 range:NSMakeRange(0, [stringWeekdays length])];
        }// End of if
        
        NSMutableArray *mweekdays = [[NSMutableArray alloc] init];
        for (NSTextCheckingResult *result in stringWeekdaysMatches)
        {
            Weekday weekday = 0;
            NSString *strWeekday = [stringWeekdays substringWithRange:result.range];
            
            if ([strWeekday isEqualToString:@"M"])
            {
                weekday = WeekdayMonday;
            }// End of if
            else if ([strWeekday isEqualToString:@"T"])
            {
                weekday = WeekdayTuesday;
            }// End of else if
            else if ([strWeekday isEqualToString:@"W"])
            {
                weekday = WeekdayWednesday;
            }// End of else if
            else if ([strWeekday isEqualToString:@"Th"])
            {
                weekday = WeekdayThursday;
            }// End of else if
            else if ([strWeekday isEqualToString:@"F"])
            {
                weekday = WeekdayFriday;
            }// End of else if
            
            [mweekdays addObject:@(weekday)];
        }// End of for
        self.weekdays = [[NSArray alloc] initWithArray:mweekdays];
        
        self.startDate = [dateFormatter dateFromString:[JSONUtils jsonValueOrNil:date forKey:@"start_date"]];
        self.startDate = [dateFormatter dateFromString:[JSONUtils jsonValueOrNil:date forKey:@"end_date"]];
        
        self.toBeAnnounced = [[JSONUtils jsonValueOrNil:date forKey:@"is_tba"] boolValue];
        self.cancelled = [[JSONUtils jsonValueOrNil:date forKey:@"is_cancelled"] boolValue];
        self.closed = [[JSONUtils jsonValueOrNil:date forKey:@"is_closed"] boolValue];
        
        NSDictionary *location = [JSONUtils jsonValueOrNil:dictionary forKey:@"location"];
        
        self.building = [JSONUtils jsonValueOrNil:location forKey:@"building"];
        self.room = [JSONUtils jsonValueOrNil:location forKey:@"room"];
        
        NSDictionary *instructors = [JSONUtils jsonValueOrNil:dictionary forKey:@"instructors"];
        
        NSMutableArray *minstructors = [[NSMutableArray alloc] init];
        for (NSString *instructor in instructors)
        {
            [minstructors addObject:instructor];
        }// End of for
        self.instructors = [[NSArray alloc] initWithArray:minstructors];
    }// End of if
    
    return self;
}// End of initWithDictionary

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.startTime = [decoder decodeObjectForKey:@"startTime"];
        self.endTime = [decoder decodeObjectForKey:@"endTime"];
        self.weekdays = [decoder decodeObjectForKey:@"weekdays"];
        self.startDate = [decoder decodeObjectForKey:@"startDate"];
        self.endDate = [decoder decodeObjectForKey:@"endDate"];
        self.toBeAnnounced = [decoder decodeBoolForKey:@"toBeAnnounced"];
        self.cancelled = [decoder decodeBoolForKey:@"cancelled"];
        self.closed = [decoder decodeBoolForKey:@"closed"];
        self.building = [decoder decodeObjectForKey:@"building"];
        self.room = [decoder decodeObjectForKey:@"room"];
        self.instructors = [decoder decodeObjectForKey:@"instructors"];
    }// End of if
    
    return self;
}// End of initWithCoder

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.startTime forKey:@"startTime"];
    [coder encodeObject:self.endTime forKey:@"endTime"];
    [coder encodeObject:self.weekdays forKey:@"weekdays"];
    [coder encodeObject:self.startDate forKey:@"startDate"];
    [coder encodeObject:self.endDate forKey:@"endDate"];
    [coder encodeBool:self.toBeAnnounced forKey:@"toBeAnnounced"];
    [coder encodeBool:self.cancelled forKey:@"cancelled"];
    [coder encodeBool:self.closed forKey:@"closed"];
    [coder encodeObject:self.building forKey:@"building"];
    [coder encodeObject:self.room forKey:@"room"];
    [coder encodeObject:self.instructors forKey:@"instructors"];
}// End of encodeWithCoder

@end
