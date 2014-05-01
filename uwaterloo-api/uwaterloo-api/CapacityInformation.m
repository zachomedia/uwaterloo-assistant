//
//  CapacityInformation.m
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-05-01.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import "CapacityInformation.h"

@implementation CapacityInformation

-(id)initWithCapacity:(NSInteger)capacity andTotal:(NSInteger)total
{
    if (self = [super init])
    {
        self.capacity = capacity;
        self.total = total;
    }// End of if
    
    return self;
}// End of initWithCapacity andTotal

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.capacity = [decoder decodeIntegerForKey:@"capacity"];
        self.total = [decoder decodeIntegerForKey:@"total"];
    }// End of if
    
    return self;
}// End of initWithCoder

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInteger:self.capacity forKey:@"subject"];
    [coder encodeInteger:self.total forKey:@"total"];
}// End of encodeWithCoder

@end
