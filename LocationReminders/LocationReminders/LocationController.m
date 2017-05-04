//
//  LocationController.m
//  LocationReminders
//
//  Created by Eve Denison on 5/2/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "LocationController.h"

#import "ViewController.h"

@import UserNotifications;

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

-(void)startMonitoringForRegion:(CLRegion *)region {
    
    [self.locationManager startMonitoringForRegion:region];

}

//MARK: User Entered Region

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"We have sucessfully started monitoring changes for region %@", region.identifier);
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"User did ENTER region: %@", region.identifier);
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"Reminder";
    content.body = [NSString stringWithFormat:@"%@", region.identifier];
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.1 repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Location Entered" content:content trigger:trigger];
    
    UNUserNotificationCenter *current = [UNUserNotificationCenter currentNotificationCenter];
    
    [current removeAllPendingNotificationRequests];
    [current addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error posting user notification: %@", error.localizedDescription);
        }
    }];
}

//Fix enter region lack of display bug, delegate has all of these methods to prevent bug
-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"User did EXIT region: %@", region.identifier);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"There was an error: %@", error.localizedDescription); //ignore if this occurs in simulator
}

-(void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit {
    NSLog(@"This visit: %@ log is here to solve bug", visit);
}


@end
