//
//  ViewController.m
//  LocationReminders
//
//  Created by Eve Denison on 5/1/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "ViewController.h"

@import Parse;
@import MapKit;

@interface ViewController () <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    
//    testObject[@"testName"] = @"Eve Denison";
//    
//    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if (succeeded) {
//            NSLog(@"Success in saving test obejct.");
//        }else {
//            NSLog(@"There was a problem saving.  Save Error: %@",  error.localizedDescription);
//        }
//        
//    }];
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"%@", error.localizedDescription);
//        }else {
//            NSLog(@"Query results %@", objects);
//        }
//    }];
    
    [self requestPermissions];
    self.mapView.showsUserLocation = YES;
    
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

-(void)setMapStyle {
    self.mapView.mapType = MKMapTypeSatellite;
}


- (IBAction)location1ButtonPressed:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6566674, -122.351096);
//Amount of map displayed on screen in meters
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.00, 500.00);
    
    [self.mapView setRegion:region animated:YES];
    [self setMapStyle];
}
- (IBAction)location2ButtonPressed:(id)sender {
    CLLocationCoordinate2D coordinateTwo = CLLocationCoordinate2DMake(41.390205, 2.154007);
    
    MKCoordinateRegion regionTwo = MKCoordinateRegionMakeWithDistance(coordinateTwo, 500.00, 500.00);
    
    
    [self.mapView setRegion:regionTwo animated:YES];
    [self setMapStyle];
}

- (IBAction)location3ButtonPressed:(id)sender {
    CLLocationCoordinate2D coordinateThree = CLLocationCoordinate2DMake(47.3769, 9.3902);
    
    MKCoordinateRegion regionThree = MKCoordinateRegionMakeWithDistance(coordinateThree, 500.00, 500.00);
    
    [self.mapView setRegion:regionThree animated:YES];
    [self setMapStyle];

}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    CLLocation *location = locations.lastObject;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 200.00, 200.00);
    
    [self.mapView setRegion:region animated:YES];
}

@end
