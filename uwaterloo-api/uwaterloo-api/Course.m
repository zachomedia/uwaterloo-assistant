//
//  Course.m
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "Course.h"

#import "JSONUtils.h"

@implementation Course

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.id = [JSONUtils jsonValueOrNil:dictionary forKey:@"course_id"];
        self.subject = [JSONUtils jsonValueOrNil:dictionary forKey:@"subject"];
        self.catalogNumber = [JSONUtils jsonValueOrNil:dictionary forKey:@"catalog_number"];
        self.title = [JSONUtils jsonValueOrNil:dictionary forKey:@"title"];
        self.units = [JSONUtils jsonValueOrNil:dictionary forKey:@"units"];
        self.description = [JSONUtils jsonValueOrNil:dictionary forKey:@"description"];
        
        NSString *level = [JSONUtils jsonValueOrNil:dictionary forKey:@"academic_level"];
        if ([level isEqualToString:@"undergraduate"])
        {
            self.academicLevel = AcademicLevelUndergraduate;
        }// End of if
        else
        {
            self.academicLevel = AcademicLevelGraduate;
        }// End of else
    }// End of if
    
    return self;
}// End of initWithDictionary

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.id = [decoder decodeObjectForKey:@"id"];
        self.subject = [decoder decodeObjectForKey:@"subject"];
        self.catalogNumber = [decoder decodeObjectForKey:@"catalogNumber"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.units = [decoder decodeObjectForKey:@"units"];
        self.description = [decoder decodeObjectForKey:@"description"];
        self.academicLevel = [decoder decodeIntegerForKey:@"academicLevel"];
        
        Log(@"Decoding Complete");
    }// End of if
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.id forKey:@"id"];
    [coder encodeObject:self.subject forKey:@"subject"];
    [coder encodeObject:self.catalogNumber forKey:@"catalogNumber"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.units forKey:@"units"];
    [coder encodeObject:self.description forKey:@"description"];
    [coder encodeInteger:self.academicLevel forKey:@"academicLevel"];
}

@end
