//
//  Weather.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic, strong) NSNumber *temperature;
@property (nonatomic, strong) NSNumber *windSpeed;
@property (nonatomic, strong) NSNumber *windDirection;
@property (nonatomic, strong) NSDate *observationTime;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
