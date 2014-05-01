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
        self.section = [JSONUtils jsonValueOrNil:dictionary forKey:@"section"];
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
        self.section = [decoder decodeObjectForKey:@"section"];
    }// End of if
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.subject forKey:@"subject"];
    [coder encodeObject:self.catalogNumber forKey:@"catalogNumber"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.section forKey:@"section"];
}

@end
