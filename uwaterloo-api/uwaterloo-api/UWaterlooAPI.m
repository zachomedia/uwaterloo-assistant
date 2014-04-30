//
//  UWaterlooAPI.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-29.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "UWaterlooAPI.h"

#import "UWaterlooAPIRequest.h"

@implementation UWaterlooAPI

-(id)initWithAPIKey:(NSString *)key andDelegate:(id)del
{
    return [self initWithAPIKey:key baseURL:[NSURL URLWithString:@"https://api.uwaterloo.ca/v2/"] andDelegate:del];
}// End of initWithAPIKey method

-(id)initWithAPIKey:(NSString *)key baseURL:(NSURL *)url andDelegate:(id)del
{
    if (self = [super init])
    {
        apiKey = key;
        baseUrl = url;
        delegate = del;
    }// End of if
    
    return self;
}// End of initWithAPIKey andBaseURL

-(UWaterlooAPIRequest *)createRequest
{
    return [[UWaterlooAPIRequest alloc] initWithAPIKey:apiKey andBaseURL:baseUrl];
}

-(void)termsWithSuccessSelector:(SEL)successSelector failureSelector:(SEL)failureSelector
{
    [[self createRequest] performRequest:@"terms/list.json" withOptions:nil successBlock:^(NSDictionary *data){
        if (successSelector != nil && [delegate respondsToSelector:successSelector])
            [delegate performSelector:successSelector withObject:[[Terms alloc] initWithDictionary:data]];
    } andFailureBlock:^(NSError *error){
        if (failureSelector != nil && [delegate respondsToSelector:failureSelector])
            [delegate performSelector:failureSelector withObject:error];
    }];
}// End of terms

-(void)weatherWithSuccessSelector:(SEL)successSelector failureSelector:(SEL)failureSelector
{
    [[self createRequest] performRequest:@"weather/current.json" withOptions:nil successBlock:^(NSDictionary *data){
        if (successSelector != nil && [delegate respondsToSelector:successSelector])
            [delegate performSelector:successSelector withObject:[[Weather alloc] initWithDictionary:data]];
    } andFailureBlock:^(NSError *error){
        if (failureSelector != nil && [delegate respondsToSelector:failureSelector])
            [delegate performSelector:failureSelector withObject:error];
    }];
}// End of weather


@end
