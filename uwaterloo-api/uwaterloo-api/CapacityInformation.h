//
//  CapacityInformation.h
//  uwaterloo-api
//
//  Created by Zachary Seguin on 2014-05-01.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CapacityInformation : NSObject <NSCoding>

@property NSInteger capacity;
@property NSInteger total;

-(id)initWithCapacity:(NSInteger)capacity andTotal:(NSInteger)total;
-(id)initWithCoder:(NSCoder *)decoder;
-(void)encodeWithCoder:(NSCoder *)coder;

@end
