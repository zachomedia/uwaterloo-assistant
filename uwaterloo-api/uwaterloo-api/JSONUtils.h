//
//  JSONUtils.h
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONUtils : NSObject

+(id)jsonValueOrNil:(NSDictionary *)json forKey:(id)key;

@end
