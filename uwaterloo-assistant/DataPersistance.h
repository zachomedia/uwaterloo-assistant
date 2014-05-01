//
//  DataPersistance.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-05-01.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPersistance : NSObject

+(NSArray *)userSections;
+(void)setUserSections:(NSArray *)sections;

@end
