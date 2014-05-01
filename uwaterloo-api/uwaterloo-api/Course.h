//
//  Course.h
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum { AcademicLevelUndergraduate, AcademicLevelGraduate } AcademicLevel;

@interface Course : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *catalogNumber;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *units;
@property (nonatomic, strong) NSString *description;
@property AcademicLevel academicLevel;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
