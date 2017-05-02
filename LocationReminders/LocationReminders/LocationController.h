//
//  LocationController.h
//  LocationReminders
//
//  Created by Eve Denison on 5/2/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;

@protocol LocationControllerDelegate <NSObject>
@required
- (void)locationControllerUpdatedLocation:(CLLocation *)location;

@end

@interface LocationController : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (weak, nonatomic) id<LocationControllerDelegate> delegate;

+(LocationController *)sharedInstance;
-(void)requestPermissions;


@end
