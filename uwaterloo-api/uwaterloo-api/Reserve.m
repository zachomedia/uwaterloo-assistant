//
//  Reserve.m
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-05-01.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "Reserve.h"

@implementation Reserve

-(id)initWithGroup:(NSString *)group andCapacityInformation:(CapacityInformation *)capacityInformation
{
    if (self = [super init])
    {
        self.group = group;
        self.capacityInformation = capacityInformation;
    }// End of if
    
    return self;
}// End of initWithCapacity andTotal

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.group = [decoder decodeObjectForKey:@"group"];
        self.capacityInformation = [decoder decodeObjectForKey:@"capacityInformation"];
    }// End of if
    
    return self;
}// End of initWithCoder

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.group forKey:@"group"];
    [coder encodeObject:self.capacityInformation forKey:@"capacityInformation"];
}// End of encodeWithCoder

@end
