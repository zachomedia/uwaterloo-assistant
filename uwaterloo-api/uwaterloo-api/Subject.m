//
//  Subject.m
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "Subject.h"

#import "JSONUtils.h"

@implementation Subject

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.code = [JSONUtils jsonValueOrNil:dictionary forKey:@"subject"];
        self.description = [JSONUtils jsonValueOrNil:dictionary forKey:@"description"];
    }// End of if
    
    return self;
}// End of initWithDictionary

@end
