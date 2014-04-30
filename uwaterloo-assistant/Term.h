//
//  Term.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-29.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Term : NSObject

@property NSInteger id;
@property (nonatomic, strong) NSString *name;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
