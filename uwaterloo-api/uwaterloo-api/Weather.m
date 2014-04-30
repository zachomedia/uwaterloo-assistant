//
//  Weather.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "Weather.h"

#import "JSONUtils.h"

@implementation Weather



-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        CGFloat stationLongitude = [[JSONUtils jsonValueOrNil:dictionary forKey:@"station_longitude"] doubleValue];
        CGFloat stationLatitude = [[JSONUtils jsonValueOrNil:dictionary forKey:@"station_latitude"] doubleValue];
        
        self.stationCoordinates = NSPointFromCGPoint(CGPointMake(stationLongitude, stationLatitude));

        self.stationElevation = [JSONUtils jsonValueOrNil:dictionary forKey:@"elevation_m"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
        
        self.observationTime = [dateFormatter dateFromString:[JSONUtils jsonValueOrNil:dictionary forKey:@"observation_time"]];
        
        self.temperature = [JSONUtils jsonValueOrNil:dictionary forKey:@"temperature_current_c"];
        self.humidex = [JSONUtils jsonValueOrNil:dictionary forKey:@"humidex_c"];
        self.windchill = [JSONUtils jsonValueOrNil:dictionary forKey:@"windchill_c"];
        
        self.maxTemperature = [JSONUtils jsonValueOrNil:dictionary forKey:@"temperature_24hr_max_c"];
        self.minTemperature = [JSONUtils jsonValueOrNil:dictionary forKey:@"temperature_24hr_min_c"];
        
        self.precipitationFifteenMinutes = [JSONUtils jsonValueOrNil:dictionary forKey:@"precipitation_15min_mm"];
        self.precipitationOneHour = [JSONUtils jsonValueOrNil:dictionary forKey:@"precipitation_1hr_mm"];
        self.precipitationTwentyFourHours = [JSONUtils jsonValueOrNil:dictionary forKey:@"precipitation_24hr_mm"];
        
        self.humidity = [JSONUtils jsonValueOrNil:dictionary forKey:@"relative_humidity_percent"];
        self.dewPoint = [JSONUtils jsonValueOrNil:dictionary forKey:@"dew_point_c"];
        
        self.windSpeed = [JSONUtils jsonValueOrNil:dictionary forKey:@"wind_speed_kph"];
        self.windDirection = [JSONUtils jsonValueOrNil:dictionary forKey:@"wind_direction_degrees"];
        
        self.pressure = [JSONUtils jsonValueOrNil:dictionary forKey:@"pressure_kpa"];
        NSString *trend = [JSONUtils jsonValueOrNil:dictionary forKey:@"pressure_trend"];
        
        if ([trend isEqualToString:@"Rising"])
        {
            self.pressureTrend = PressureTrendRising;
        }// End of if
        else if ([trend isEqualToString:@"Falling"])
        {
            self.pressureTrend = PressureTrendFalling;
        }// End of else if
        else
        {
            self.pressureTrend = PressureTrendUnchanged;
        }// End of else
        
        self.shortwaveRadiation = [JSONUtils jsonValueOrNil:dictionary forKey:@"incoming_shortwave_radiation_wm2"];
        
    }// End of if
    
    return self;
}// End of initWithDictionary

@end
