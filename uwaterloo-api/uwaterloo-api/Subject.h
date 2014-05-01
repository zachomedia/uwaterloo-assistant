//
//  Subject.h
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Subject : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *description;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
