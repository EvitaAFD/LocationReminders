//
//  LocationController.m
//  LocationReminders
//
//  Created by Eve Denison on 5/2/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "LocationController.h"

#import "ViewController.h"

@import MapKit;


@implementation LocationController

+(LocationController *)sharedInstance {
    static LocationController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LocationController alloc]init];
    
    });
    
    return sharedInstance;

}


-(void)requestPermissions {
    self.locationManager = [[CLLocationManager alloc]init];
    
    [self.locationManager requestAlwaysAuthorization];
    
    self.locationManager.delegate = self;
    
//Location monitoring settings
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100; //meters
    [self.locationManager startUpdatingLocation];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self requestPermissions];
    }
    return self;
}

//MARK: locationManager didUpdateLocation delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = locations.lastObject;
    
    [self.delegate locationControllerUpdatedLocation:location];
}


@end
