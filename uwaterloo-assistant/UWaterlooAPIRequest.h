//
//  UWaterlooAPIRequest.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-29.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define API_REQUEST_TIMEOUT 60.0
typedef void (^UWaterlooAPISuccessBlock)(NSDictionary *);
typedef void (^UWaterlooAPIFailureBlock)(NSError *);

// TODO: Check response code of API request.

@interface UWaterlooAPIRequest : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSString *apiKey;
    NSURL *baseUrl;
    
    UWaterlooAPISuccessBlock requestSuccessBlock;
    UWaterlooAPIFailureBlock requestFailureBlock;
    
    NSURLConnection *requestConnection;
    NSMutableData *requestData;
}

-(id)initWithAPIKey:(NSString *)key andBaseURL:(NSURL *)url;

-(void)performRequest:(NSString *)method withOptions:(NSDictionary *)options successBlock:(UWaterlooAPISuccessBlock)successBlock andFailureBlock:(UWaterlooAPIFailureBlock)failureBlock;

@end
