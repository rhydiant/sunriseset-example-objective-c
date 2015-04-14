//
//  SunEvent.h
//  SunriseSetWatch
//
//  Created by Rhydian Thomas on 14/04/2015.
//  Copyright (c) 2015 DiUS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SunEvent : NSObject

@property(nonatomic) NSString *time;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *icon;

- (void)recalculate;

+ (SunEvent*)sunriseAt:(NSTimeZone *)timezone latitude:(double)latitude longitude:(double)longitude;

+ (SunEvent*)sunsetAt:(NSTimeZone *)timezone latitude:(double)latitude longitude:(double)longitude;

@end
