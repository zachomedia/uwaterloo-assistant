//
//  Weather.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "Weather.h"

@implementation Weather

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.temperature = [dictionary objectForKey:@"temperature_current_c"];
        self.windSpeed = [dictionary objectForKey:@"wind_speed_kph"];
        self.windDirection = [dictionary objectForKey:@"wind_direction_degrees"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];

        self.observationTime = [dateFormatter dateFromString:[dictionary objectForKey:@"observation_time"]];
    }// End of if
    
    return self;
}// End of initWithDictionary

@end
