//
//  SunEvent.m
//  SunriseSetWatch
//
//  Created by Rhydian Thomas on 14/04/2015.
//  Copyright (c) 2015 DiUS. All rights reserved.
//

#import "SunEvent.h"

#import "EDSunriseSet.h"

static NSString* const kSunrise = @"Sunrise";
static NSString* const kSunset = @"Sunset";

@interface SunEvent()
@property(nonatomic) NSTimeZone *timezone;
@property(nonatomic) double latitude;
@property(nonatomic) double longitude;
@end

@implementation SunEvent

- (instancetype)initWithTimeZone:(NSTimeZone *)timezone latitude:(double)latitude longitude:(double)longitude {
  self = [super init];
  if (self) {
    self.timezone = timezone;
    self.latitude = latitude;
    self.longitude = longitude;
  }
  return self;
}

+ (SunEvent*)sunriseAt:(NSTimeZone *)timezone latitude:(double)latitude longitude:(double)longitude {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setTimeStyle:NSDateFormatterFullStyle];
  
  SunEvent *sunrise = [[SunEvent alloc] initWithTimeZone:timezone latitude:latitude longitude:longitude];
  sunrise.name = kSunrise;
  sunrise.time = [SunEvent sunriseTimeAt:timezone latitude:latitude longitude:longitude];
  sunrise.icon = [kSunrise lowercaseString];
  return sunrise;
}

+ (SunEvent*)sunsetAt:(NSTimeZone *)timezone latitude:(double)latitude longitude:(double)longitude {
  SunEvent *sunset = [[SunEvent alloc] initWithTimeZone:timezone latitude:latitude longitude:longitude];
  sunset.name = kSunset;
  sunset.time = [SunEvent sunsetTimeAt:timezone latitude:latitude longitude:longitude];
  sunset.icon = [kSunset lowercaseString];
  return sunset;
}

- (void)recalculate {
  if ([self.name isEqualToString:kSunset]) {
    self.time = [SunEvent sunsetTimeAt:self.timezone latitude:self.latitude longitude:self.longitude];
  } else {
    self.time = [SunEvent sunriseTimeAt:self.timezone latitude:self.latitude longitude:self.longitude];
  }
}

#pragma mark - helpers

+ (NSString *)sunriseTimeAt:(NSTimeZone *)timezone latitude:(double)latitude longitude:(double)longitude {
  NSDate *sunrise = [SunEvent sunriseSunsetAt:timezone latitude:latitude longitude:longitude].sunrise;
  return [[self formatter] stringFromDate:sunrise];
}

+ (NSString *)sunsetTimeAt:(NSTimeZone *)timezone latitude:(double)latitude longitude:(double)longitude {
  NSDate *sunset = [SunEvent sunriseSunsetAt:timezone latitude:latitude longitude:longitude].sunset;
  return [[self formatter] stringFromDate:sunset];
}

+ (EDSunriseSet *)sunriseSunsetAt:(NSTimeZone *)timezone latitude:(double)latitude longitude:(double)longitude {
  EDSunriseSet *sunriseSunset = [[EDSunriseSet alloc] initWithTimezone:timezone
                                                              latitude:latitude
                                                             longitude:longitude];
  [sunriseSunset calculateSunriseSunset:[NSDate date]];
  return sunriseSunset;
}

+ (NSDateFormatter *)formatter {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"h:MM a"];
  return formatter;
}

@end
