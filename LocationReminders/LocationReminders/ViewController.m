//
//  ViewController.m
//  LocationReminders
//
//  Created by Eve Denison on 5/1/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "ViewController.h"
#import "AddReminderViewController.h"

@import Parse;
@import MapKit;

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestPermissions];
    
    self.mapView.showsUserLocation = YES;
    
    self.mapView.delegate = self;
    
    
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

//MARK: didUpdateLocation
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    CLLocation *location = locations.lastObject;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 200.00, 200.00);
    
    [self.mapView setRegion:region animated:YES];
}

//MARK: Apply Annotation View
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
//Ensure custom pins don't override user's pins
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
    
    annotationView.annotation = annotation;
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
    }
    
    annotationView.canShowCallout = YES;
//    annotationView.animatesDrop = YES;
    
    UIButton *rightCalloutAccessory = [UIButton buttonWithType:UIButtonTypeDetailDisclosure]; //callout button
    
    annotationView.rightCalloutAccessoryView = rightCalloutAccessory;
    
    return annotationView;
}

@end
