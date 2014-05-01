//
//  Subjects.h
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Subject.h"

@interface Subjects : NSObject

@property NSDictionary *subjects;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
