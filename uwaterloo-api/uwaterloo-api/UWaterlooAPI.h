//
//  UWaterlooAPI.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-29.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Terms.h"
#import "Weather.h"

@interface UWaterlooAPI : NSObject

-(id)initWithAPIKey:(NSString *)key andDelegate:(id)delegate;
-(id)initWithAPIKey:(NSString *)key baseURL:(NSURL *)url andDelegate:(id)delegate;

-(void)termsWithSuccessSelector:(SEL)successSelector failureSelector:(SEL)failureSelector;

-(void)weatherWithSuccessSelector:(SEL)successSelector failureSelector:(SEL)failureSelector;

@end
