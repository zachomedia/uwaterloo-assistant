//
//  Term.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-29.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "Term.h"

#import "JSONUtils.h"

@implementation Term

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.id = [[JSONUtils jsonValueOrNil:dictionary forKey:@"id"] integerValue];
        self.name = [JSONUtils jsonValueOrNil:dictionary forKey:@"name"];
    }// End of if
    
    return self;
}// End of initWithDictionary

@end
