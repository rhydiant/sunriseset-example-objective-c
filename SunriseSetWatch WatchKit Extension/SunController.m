//
//  SunController.m
//  SunriseSetWatch
//
//  Created by Rhydian Thomas on 14/04/2015.
//  Copyright (c) 2015 DiUS. All rights reserved.
//

#import "SunController.h"

#import "SunEvent.h"

@interface SunController () {
  SunEvent *_sunEvent;
}
@property (weak, nonatomic) IBOutlet WKInterfaceImage *eventImage;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *eventTimeLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *eventNameLabel;
@end

@implementation SunController

- (void)awakeWithContext:(id)context {
  [super awakeWithContext:context];
  // context is a SunEvent (sunrise or sunset)
  _sunEvent = context;
}

- (void)willActivate {
  [super willActivate];
  
  // recaculate sunrise/sunset times on each load
  [_sunEvent recalculate];
  
  // set outlets
  [self.eventImage setImageNamed:_sunEvent.icon];
  [self.eventTimeLabel setText:_sunEvent.time];
  [self.eventNameLabel setText:_sunEvent.name];
}

@end



