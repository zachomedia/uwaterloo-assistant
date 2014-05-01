//
//  Section.m
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-05-01.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "Section.h"

#import "JSONUtils.h"

@implementation Section

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.subject = [JSONUtils jsonValueOrNil:dictionary forKey:@"subject"];
        self.catalogNumber = [JSONUtils jsonValueOrNil:dictionary forKey:@"catalog_number"];
        self.title = [JSONUtils jsonValueOrNil:dictionary forKey:@"title"];
        self.units = [JSONUtils jsonValueOrNil:dictionary forKey:@"units"];
        self.note = [JSONUtils jsonValueOrNil:dictionary forKey:@"note"];
        self.classNumber = [[JSONUtils jsonValueOrNil:dictionary forKey:@"class_number"] integerValue];
        self.section = [JSONUtils jsonValueOrNil:dictionary forKey:@"section"];
        self.campus = [JSONUtils jsonValueOrNil:dictionary forKey:@"campus"];
        self.associatedClass = [[JSONUtils jsonValueOrNil:dictionary forKey:@"associatedClass"] integerValue];
        
        NSMutableArray *mrelatedComponents = [[NSMutableArray alloc] init];
        NSString *relatedComponent1 = [JSONUtils jsonValueOrNil:dictionary forKey:@"related_component_1"];
        NSString *relatedComponent2 = [JSONUtils jsonValueOrNil:dictionary forKey:@"related_component_2"];
        
        if (relatedComponent1 != nil)
            [mrelatedComponents addObject:relatedComponent1];
        
        if (relatedComponent2 != nil)
            [mrelatedComponents addObject:relatedComponent2];
        
        self.relatedComponents = [[NSArray alloc] initWithArray:mrelatedComponents];
        
        self.enrollmentCapacityInformation = [[CapacityInformation alloc] initWithCapacity:[[JSONUtils jsonValueOrNil:dictionary forKey:@"enrollment_capacity"] integerValue] andTotal:[[JSONUtils jsonValueOrNil:dictionary forKey:@"enrollment_total"] integerValue]];
        self.waitingCapacityInformation = [[CapacityInformation alloc] initWithCapacity:[[JSONUtils jsonValueOrNil:dictionary forKey:@"waiting_capacity"] integerValue] andTotal:[[JSONUtils jsonValueOrNil:dictionary forKey:@"waiting_total"] integerValue]];
        
        self.topic = [JSONUtils jsonValueOrNil:dictionary forKey:@"topic"];
        
        NSMutableArray *mreserves = [[NSMutableArray alloc] init];
        for (NSDictionary *jsonReserve in [JSONUtils jsonValueOrNil:dictionary forKey:@"reserves"])
        {
            [mreserves addObject:[[Reserve alloc] initWithGroup:[JSONUtils jsonValueOrNil:jsonReserve forKey:@"group"] andCapacityInformation:[[CapacityInformation alloc] initWithCapacity:[[JSONUtils jsonValueOrNil:dictionary forKey:@"enrollment_capacity"] integerValue] andTotal:[[JSONUtils jsonValueOrNil:dictionary forKey:@"enrollment_total"] integerValue]]]];
        }// End of for
        self.reserves = [[NSArray alloc] initWithArray:mreserves];
        
        NSMutableArray *msessions = [[NSMutableArray alloc] init];
        for (NSDictionary *jsonSession in [JSONUtils jsonValueOrNil:dictionary forKey:@"classes"])
        {
            [msessions addObject:[[Session alloc] initWithDictionary:jsonSession]];
        }// End of for
        self.sessions = [[NSArray alloc] initWithArray:msessions];
        
        self.heldWith = [JSONUtils jsonValueOrNil:dictionary forKey:@"held_with"];
        self.term = [[JSONUtils jsonValueOrNil:dictionary forKey:@"term"] integerValue];
        
        NSString *level = [JSONUtils jsonValueOrNil:dictionary forKey:@"academic_level"];
        if ([level isEqualToString:@"undergraduate"])
        {
            self.academicLevel = AcademicLevelUndergraduate;
        }// End of if
        else
        {
            self.academicLevel = AcademicLevelGraduate;
        }// End of else
        
        NSDateFormatter *lastUpdatedDateFormatter = [[NSDateFormatter alloc] init];
        [lastUpdatedDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
        
        self.lastUpdated = [lastUpdatedDateFormatter dateFromString:[JSONUtils jsonValueOrNil:dictionary forKey:@"last_updated"]];
    }// End of if
    
    return self;
}// End of initWithDictionary

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.subject = [decoder decodeObjectForKey:@"subject"];
        self.catalogNumber = [decoder decodeObjectForKey:@"catalogNumber"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.units = [decoder decodeObjectForKey:@"units"];
        self.note = [decoder decodeObjectForKey:@"note"];
        self.classNumber = [decoder decodeIntegerForKey:@"classNumber"];
        self.section = [decoder decodeObjectForKey:@"section"];
        self.campus = [decoder decodeObjectForKey:@"campus"];
        self.associatedClass = [decoder decodeIntegerForKey:@"associatedClass"];
        self.relatedComponents = [decoder decodeObjectForKey:@"relatedComponents"];
        self.enrollmentCapacityInformation = [decoder decodeObjectForKey:@"enrollmentCapacityInformation"];
        self.waitingCapacityInformation = [decoder decodeObjectForKey:@"waitingCapacityInformation"];
        self.topic = [decoder decodeObjectForKey:@"topic"];
        self.reserves = [decoder decodeObjectForKey:@"reserves"];
        self.sessions = [decoder decodeObjectForKey:@"sessions"];
        self.heldWith = [decoder decodeObjectForKey:@"heldWith"];
        self.term = [decoder decodeIntegerForKey:@"term"];
        self.academicLevel = [decoder decodeIntegerForKey:@"academicLevel"];
        self.lastUpdated = [decoder decodeObjectForKey:@"lastUpdated"];
    }// End of if
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.subject forKey:@"subject"];
    [coder encodeObject:self.catalogNumber forKey:@"catalogNumber"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.units forKey:@"units"];
    [coder encodeObject:self.note forKey:@"note"];
    [coder encodeInteger:self.classNumber forKey:@"classNumber"];
    [coder encodeObject:self.section forKey:@"section"];
    [coder encodeObject:self.campus forKey:@"campus"];
    [coder encodeInteger:self.associatedClass forKey:@"associatedClass"];
    [coder encodeObject:self.relatedComponents forKey:@"relatedComponents"];
    [coder encodeObject:self.enrollmentCapacityInformation forKey:@"enrollmentCapacityInformation"];
    [coder encodeObject:self.waitingCapacityInformation forKey:@"waitingCapacityInformation"];
    [coder encodeObject:self.topic forKey:@"topic"];
    [coder encodeObject:self.reserves forKey:@"reserves"];
    [coder encodeObject:self.sessions forKey:@"sessions"];
    [coder encodeObject:self.heldWith forKey:@"heldWith"];
    [coder encodeInteger:self.term forKey:@"term"];
    [coder encodeInteger:self.academicLevel forKey:@"academicLevel"];
    [coder encodeObject:self.lastUpdated forKey:@"lastUpdated"];
}

@end
