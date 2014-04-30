//
//  UWaterlooAPIRequest.m
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-29.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "UWaterlooAPIRequest.h"

@implementation UWaterlooAPIRequest
{
    NSString *apiKey;
    NSURL *baseUrl;
    
    UWaterlooAPISuccessBlock requestSuccessBlock;
    UWaterlooAPIFailureBlock requestFailureBlock;
    
    NSURLConnection *requestConnection;
    NSMutableData *requestData;
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

-(void)performRequest:(NSString *)method withOptions:(NSDictionary *)options successBlock:(UWaterlooAPISuccessBlock)successBlock andFailureBlock:(UWaterlooAPIFailureBlock)failureBlock
{
    if (requestConnection != nil)
    {
        Log(@"A request is already in progress... Use a new request object.");
        return;
    }// End of if
    
    requestSuccessBlock = successBlock;
    requestFailureBlock = failureBlock;
    
    NSMutableDictionary *query_options = [[NSMutableDictionary alloc] initWithDictionary:options];
    [query_options setObject:apiKey forKey:@"key"];
    BOOL first = YES;
    
    NSString *query_string = @"";
    
    for (NSString *key in query_options)
    {
        if (first)
        {
            query_string = [NSString stringWithFormat:@"?%@=%@", key, [query_options objectForKey:key]];
            first = NO;
        }// End of if
        else
        {
            query_string = [NSString stringWithFormat:@"%@&%@=%@", query_string, key, [query_options objectForKey:key]];
        }// End of else
        
    }// End of for
    
    NSURL *url = [NSURL URLWithString:query_string relativeToURL:[NSURL URLWithString:method relativeToURL:baseUrl]];
    Log("Request URL: %@", [url description]);
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:API_REQUEST_TIMEOUT];
    
    requestConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    requestData = [[NSMutableData alloc] init];
}// End of performRequest withOptions successSelector andFailureSelector

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection != requestConnection)
        return;
    
    [requestData setLength:0];
}// End of connection didReceiveResponse

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection != requestConnection)
        return;
    
    [requestData appendData:data];
}// End of connection didReceiveData

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (connection != requestConnection)
        return;
        
    connection = nil;
    Log(@"Request connection failed. Error was: %@", [error description]);
    
    if (requestFailureBlock != nil)
        requestFailureBlock(error);
}// End of connection didFailWithError

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection != requestConnection)
        return;
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:requestData options:NSUTF8StringEncoding error:&error];
    
    if (error)
    {
        Log("Error parsing JSON. Error was: %@", [error description]);
        
        if (requestFailureBlock != nil)
            requestFailureBlock(error);
    }// End of if
    else
    {
        Log(@"JSON: %@", [json description]);
        
        Log(@"Request completed");
        
        if (requestSuccessBlock != nil)
            requestSuccessBlock([json objectForKey:@"data"]);
    }// End of else
}// End of connectionDidFinishLoading

@end
