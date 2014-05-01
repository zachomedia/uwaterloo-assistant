//
//  Subjects.m
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "Subjects.h"

@implementation Subjects

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        NSMutableDictionary *msubjects = [[NSMutableDictionary alloc] init];
        for (NSDictionary *json_subject in dictionary)
        {
            Subject *subject = [[Subject alloc] initWithDictionary:json_subject];
            [msubjects setObject:subject forKey:subject.code];
        }// End of for
        
        self.subjects = [[NSDictionary alloc] initWithDictionary:msubjects];
    }// End of if
    
    return self;
}// End of initWithDictionary

@end
