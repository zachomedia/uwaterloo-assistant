//
//  Weather.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum { PressureTrendRising, PressureTrendFalling, PressureTrendUnchanged } PressureTrend;

@interface Weather : NSObject

@property NSPoint stationCoordinates;
@property (nonatomic, strong) NSNumber *stationElevation;

@property (nonatomic, strong) NSDate *observationTime;

@property (nonatomic, strong) NSNumber *temperature;
@property (nonatomic, strong) NSNumber *humidex;
@property (nonatomic, strong) NSNumber *windchill;

@property (nonatomic, strong) NSNumber *maxTemperature;
@property (nonatomic, strong) NSNumber *minTemperature;

@property (nonatomic, strong) NSNumber *precipitationFifteenMinutes;
@property (nonatomic, strong) NSNumber *precipitationOneHour;
@property (nonatomic, strong) NSNumber *precipitationTwentyFourHours;

@property (nonatomic, strong) NSNumber *humidity;

@property (nonatomic, strong) NSNumber *dewPoint;

@property (nonatomic, strong) NSNumber *windSpeed;
@property (nonatomic, strong) NSNumber *windDirection;

@property (nonatomic, strong) NSNumber *pressure;
@property PressureTrend pressureTrend;

@property (nonatomic, strong) NSNumber *shortwaveRadiation;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
