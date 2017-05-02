//
//  LocationController.h
//  LocationReminders
//
//  Created by Eve Denison on 5/2/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;

@interface LocationController : NSObject

+(LocationController *)sharedInstance;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) id delegate;

@end
