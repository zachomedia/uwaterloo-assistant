//
//  Session.h
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-05-01.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum { WeekdaySunday, WeekdayMonday, WeekdayTuesday, WeekdayWednesday, WeekdayThursday, WeekdayFriday, WeekdaySaturday } Weekday;

@interface Session : NSObject

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic, strong) NSArray *weekdays;

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@property BOOL toBeAnnounced;
@property BOOL cancelled;
@property BOOL closed;

@property (nonatomic, strong) NSString *building;
@property (nonatomic, strong) NSString *room;

@property (nonatomic, strong) NSArray *instructors;

-(id)initWithDictionary:(NSDictionary *)dictionary;
-(id)initWithCoder:(NSCoder *)decoder;
-(void)encodeWithCoder:(NSCoder *)coder;

@end
