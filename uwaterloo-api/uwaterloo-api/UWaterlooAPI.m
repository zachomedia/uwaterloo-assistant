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
{
    NSString *apiKey;
    NSURL *baseUrl;
}

-(id)initWithAPIKey:(NSString *)key
{
    return [self initWithAPIKey:key andBaseURL:[NSURL URLWithString:@"https://api.uwaterloo.ca/v2/"]];
}

-(id)initWithAPIKey:(NSString *)key andBaseURL:(NSURL *)url
{
    if (self = [super init])
    {
        apiKey = key;
        baseUrl = url;
    }// End of if
    
    return self;
}// End of initWithAPIKey andBaseURL

-(UWaterlooAPIRequest *)createRequest
{
    return [[UWaterlooAPIRequest alloc] initWithAPIKey:apiKey andBaseURL:baseUrl];
}

-(void)termsWithTarget:(id)target successSelector:(SEL)successSelector andFailureSelector:(SEL)failureSelector
{
    [[self createRequest] performRequest:@"terms/list.json" withOptions:nil successBlock:^(NSDictionary *data){
        if (successSelector != nil && [target respondsToSelector:successSelector])
            [target performSelector:successSelector withObject:[[Terms alloc] initWithDictionary:data]];
    } andFailureBlock:^(NSError *error){
        if (failureSelector != nil && [target respondsToSelector:failureSelector])
            [target performSelector:failureSelector withObject:error];
    }];
}// End of terms

-(void)weatherWithTarget:(id)target successSelector:(SEL)successSelector andFailureSelector:(SEL)failureSelector
{
    [[self createRequest] performRequest:@"weather/current.json" withOptions:nil successBlock:^(NSDictionary *data){
        if (successSelector != nil && [target respondsToSelector:successSelector])
            [target performSelector:successSelector withObject:[[Weather alloc] initWithDictionary:data]];
    } andFailureBlock:^(NSError *error){
        if (failureSelector != nil && [target respondsToSelector:failureSelector])
            [target performSelector:failureSelector withObject:error];
    }];
}// End of weather

-(void)subjectsWithTarget:(id)target successSelector:(SEL)successSelector andFailureSelector:(SEL)failureSelector
{
    [[self createRequest] performRequest:@"codes/subjects.json" withOptions:nil successBlock:^(NSDictionary *data){
        if (successSelector != nil && [target respondsToSelector:successSelector])
            [target performSelector:successSelector withObject:[[Subjects alloc] initWithDictionary:data]];
    } andFailureBlock:^(NSError *error){
        if (failureSelector != nil && [target respondsToSelector:failureSelector])
            [target performSelector:failureSelector withObject:error];
    }];
}// End of subjects

-(void)coursesForSubjectCode:(NSString *)subjectCode withTarget:(id)target successSelector:(SEL)successSelector andFailureSelector:(SEL)failureSelector
{
    [[self createRequest] performRequest:[NSString stringWithFormat:@"courses/%@.json", subjectCode] withOptions:nil successBlock:^(NSDictionary *data){
        
        NSMutableArray *mcourses = [[NSMutableArray alloc] init];
        for (NSDictionary *json_course in data)
        {
            [mcourses addObject:[[Course alloc] initWithDictionary:json_course]];
        }// End of for
        
        if (successSelector != nil && [target respondsToSelector:successSelector])
            [target performSelector:successSelector withObject:[[NSArray alloc] initWithArray:mcourses]];
    } andFailureBlock:^(NSError *error){
        if (failureSelector != nil && [target respondsToSelector:failureSelector])
            [target performSelector:failureSelector withObject:error];
    }];
}// End of courses


@end
