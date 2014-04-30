//
//  Terms.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-29.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "Terms.h"

@implementation Terms

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        NSMutableDictionary *listings = [[NSMutableDictionary alloc] init];
        NSDictionary *json_listings = [dictionary objectForKey:@"listings"];
        for (NSString *key in json_listings)
        {
            NSDictionary *year_terms = [json_listings objectForKey:key];
            
            for (NSDictionary *json_term in year_terms)
            {
                Term *term = [[Term alloc] initWithDictionary:json_term];
                              
                [listings setObject:term forKey:[NSString stringWithFormat:@"%zd", term.id]];
            }// End of for
        }// End of for
        
        self.terms = [[NSDictionary alloc] initWithDictionary:listings];
        
        self.currentTerm = [self termForId:[[dictionary objectForKey:@"current_term"] integerValue]];
        self.previousTerm = [self termForId:[[dictionary objectForKey:@"previous_term"] integerValue]];
        self.nextTerm = [self termForId:[[dictionary objectForKey:@"next_term"] integerValue]];
    }// End of if
    
    return self;
}// End of initWithDictionary

-(Term *)termForId:(NSInteger)id
{
    return [self.terms objectForKey:[NSString stringWithFormat:@"%zd", id]];
}// End of termForId

@end
