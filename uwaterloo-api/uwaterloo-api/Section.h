//
//  Section.h
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-05-01.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject

@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *catalogNumber;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *section;

-(id)initWithDictionary:(NSDictionary *)dictionary;
-(id)initWithCoder:(NSCoder *)decoder;
-(void)encodeWithCoder:(NSCoder *)coder;

@end
