//
//  JSONUtils.m
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "JSONUtils.h"

@implementation JSONUtils

+(id)jsonValueOrNil:(NSDictionary *)json forKey:(id)key
{
    id value = [json objectForKey:key];
    
    if (value == [NSNull null])
    {
        return nil;
    }// End of if
    else
    {
        return value;
    }// End of else
}// End of jsonValueOrNil

@end
