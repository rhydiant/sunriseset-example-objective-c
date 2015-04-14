//
//  LaunchController.m
//  SunriseSetWatch WatchKit Extension
//
//  Created by Rhydian Thomas on 14/04/2015.
//  Copyright (c) 2015 DiUS. All rights reserved.
//

#import "LaunchController.h"

#import "SunEvent.h"

static NSString* const kSunControllerIdentifier = @"SunController";

@interface LaunchController()

@end

@implementation LaunchController

#pragma mark - WKInterfaceController

- (instancetype)init {
  self = [super init];
  if (self) {
    
    // we can use location services on the phone to get the users current
    // location, but for demo purposes we'll use a fixed location
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Australia/Sydney"];
    double latitude = -33.890335;
    double longitude = 151.222449;
    
    // reload with a page controller; one page for sunrise another for sunset
    [WKInterfaceController reloadRootControllersWithNames:@[kSunControllerIdentifier, kSunControllerIdentifier]
                                                 contexts:@[[SunEvent sunriseAt:timezone latitude:latitude longitude:longitude],
                                                            [SunEvent sunsetAt:timezone latitude:latitude longitude:longitude]]];
  }
  return self;
}

@end



