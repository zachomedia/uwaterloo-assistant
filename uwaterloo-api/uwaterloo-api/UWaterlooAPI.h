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
#import "Subjects.h"
#import "Course.h"

@interface UWaterlooAPI : NSObject

-(id)initWithAPIKey:(NSString *)key;
-(id)initWithAPIKey:(NSString *)key andBaseURL:(NSURL *)url;

-(void)termsWithTarget:(id)target successSelector:(SEL)successSelector andFailureSelector:(SEL)failureSelector;

-(void)weatherWithTarget:(id)target successSelector:(SEL)successSelector andFailureSelector:(SEL)failureSelector;

-(void)subjectsWithTarget:(id)target successSelector:(SEL)successSelector andFailureSelector:(SEL)failureSelector;

-(void)coursesForSubjectCode:(NSString *)subjectCode withTarget:(id)target successSelector:(SEL)successSelector andFailureSelector:(SEL)failureSelector;

@end
