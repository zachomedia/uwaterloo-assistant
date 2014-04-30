//
//  Terms.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-29.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Term.h"

@interface Terms : NSObject

@property (nonatomic, weak)Term *currentTerm;
@property (nonatomic, weak)Term *previousTerm;
@property (nonatomic, weak)Term *nextTerm;

@property (nonatomic, strong) NSDictionary *terms;

-(id)initWithDictionary:(NSDictionary *)dictionary;
-(Term *)termForId:(NSInteger)id;

@end
