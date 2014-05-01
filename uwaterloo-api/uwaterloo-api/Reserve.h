//
//  Reserve.h
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-05-01.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CapacityInformation.h"

@interface Reserve : NSObject

@property (nonatomic, strong) NSString *group;
@property (nonatomic, strong) CapacityInformation *capacityInformation;

-(id)initWithGroup:(NSString *)group andCapacityInformation:(CapacityInformation *)capacityInformation;
-(id)initWithCoder:(NSCoder *)decoder;
-(void)encodeWithCoder:(NSCoder *)coder;

@end
