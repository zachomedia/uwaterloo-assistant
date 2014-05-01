//
//  Section.h
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-05-01.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CapacityInformation.h"
#import "Reserve.h"
#import "Session.h"
#import "Course.h"

@interface Section : NSObject <NSCoding>

@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *catalogNumber;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *units;
@property (nonatomic, strong) NSString *note;
@property NSInteger classNumber;
@property (nonatomic, strong) NSString *section;
@property (nonatomic, strong) NSString *campus;
@property NSInteger associatedClass;
@property (nonatomic, strong) NSArray* relatedComponents;

@property (nonatomic, strong) CapacityInformation *enrollmentCapacityInformation;
@property (nonatomic, strong) CapacityInformation *waitingCapacityInformation;
@property (nonatomic, strong) NSString *topic;

@property (nonatomic, strong) NSArray *reserves;
@property (nonatomic, strong) NSArray *sessions;

@property (nonatomic, strong) NSString *heldWith;
@property NSInteger term;
@property AcademicLevel academicLevel;
@property (nonatomic, strong) NSDate *lastUpdated;

-(id)initWithDictionary:(NSDictionary *)dictionary;
-(id)initWithCoder:(NSCoder *)decoder;
-(void)encodeWithCoder:(NSCoder *)coder;

@end