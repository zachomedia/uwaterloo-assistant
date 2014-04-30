//
//  PreferencesModifier.h
//  uWaterloo Assistant
//
//  Created by Zachary Seguin on 2014-04-30.
//  Copyright (c) 2014 Zachary Seguin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PreferencesModifier <NSObject>

-(void)savePreferences;

@end
