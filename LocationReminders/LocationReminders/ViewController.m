//
//  ViewController.m
//  LocationReminders
//
//  Created by Eve Denison on 5/1/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "ViewController.h"
#import "AddReminderViewController.h"

#import "LocationController.h"

#import "Reminder.h"

@import Parse;
@import MapKit;

#import <ParseUI/ParseUI.h>

@interface ViewController () <MKMapViewDelegate, LocationControllerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.mapView.showsUserLocation = YES;
    
    self.mapView.delegate = self;
    
    [self setMapStyle];
    
    [[LocationController sharedInstance] setDelegate:self];
    
    [PFUser logOut];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reminderSavedToParse:) name:@"reminderSavedToParse" object:nil];
    
    if (![PFUser currentUser]) {
        PFLogInViewController *loginViewController = [[PFLogInViewController alloc] init];
        
        loginViewController.delegate = self;
        loginViewController.signUpController.delegate = self;
        
        loginViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsFacebook | PFLogInFieldsSignUpButton;
        
        loginViewController.logInView.logo = [[UIView alloc] init];
        
        [self presentViewController:loginViewController animated:YES completion:nil];
        NSLog(@"OVERLAYS: %@", self.mapView.overlays);
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self fecthedReminder];

}

-(void)setMapStyle {
    self.mapView.mapType = MKMapTypeSatellite;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"AddReminderViewController"] && [sender isKindOfClass:[MKPinAnnotationView class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)sender;
        
        AddReminderViewController *newReminderViewController = (AddReminderViewController *)segue.destinationViewController;
        
        newReminderViewController.coordinate = annotationView.annotation.coordinate;
        newReminderViewController.annotationTitle = annotationView.annotation.title;
        newReminderViewController.title = annotationView.annotation.title;
        
       
//hulk strong reference bruce weak pointer, makes bridge into block to avoid retain cycle
        __weak typeof(self) bruce = self;
        
        newReminderViewController.completion = ^(MKCircle *circle) {
            
            __strong typeof(bruce) hulk = bruce;
            
            [hulk.mapView removeAnnotation:annotationView.annotation];
            [hulk.mapView addOverlay:circle];
        };
        
    }
    
}

-(void)reminderSavedToParse:(id)sender {

    NSLog(@"Reminder saved to Parse.");
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReminderSavedToParse" object:nil];

}

//MARK: Actions
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

- (IBAction)userLongPressedMap:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
//Where user touched map
        CGPoint touchPoint = [sender locationInView:self.mapView];
        
//Converts user touch into location on map
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        
        newPoint.coordinate = coordinate;
        newPoint.title = @"My New Location";
        
        [self.mapView addAnnotation:newPoint];
    }
}

//MARK: mapView delegatation methods
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
//Ensure custom pins don't override user's pins
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
    
    
    annotationView.annotation = annotation;
    

    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
        [annotationView setPinTintColor:[UIColor colorWithHue:drand48() saturation:1.0 brightness:1.0 alpha:1.0]];
    }
    
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    
    UIButton *rightCalloutAccessory = [UIButton buttonWithType:UIButtonTypeDetailDisclosure]; //callout button
    
    annotationView.rightCalloutAccessoryView = rightCalloutAccessory;
    
    return annotationView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {

    [self performSegueWithIdentifier:@"AddReminderViewController" sender:view];
}

- (void)locationControllerUpdatedLocation:(CLLocation *)location {
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 200.00, 200.00);
    
    [self.mapView setRegion:region animated:YES];
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithCircle:overlay];
    
    renderer.strokeColor = [UIColor colorWithRed:0.62 green:0.22 blue:0.94 alpha:1.0];
    renderer.fillColor = [UIColor colorWithRed:0.22 green:0.94 blue:0.89 alpha:1.0];
    renderer.alpha = 0.30;
    
    return renderer;

}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {

    [self  dismissViewControllerAnimated:YES completion:nil];
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {

    [self  dismissViewControllerAnimated:YES completion:nil];
}

-(void)fecthedReminder {
    PFQuery *reminderQuery = [PFQuery queryWithClassName:@"Reminder"];
    [reminderQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error Fetching Reminders %@", error.localizedDescription);
        }
        for (Reminder *reminder in objects) {
            NSLog(@"New Reminder Name: %@, Reminder LOCATION: %@, Reminder Radius: %@.", reminder.reminderName, reminder.location, reminder.radius);
            [self displayMapOverlay:reminder];
        }

    }];
}

-(void)displayMapOverlay:(Reminder *)reminder {
    BOOL hasCurrentAnnotation = NO;
    for(MKCircle *mapOverlay in self.mapView.overlays) {
        if ((mapOverlay.coordinate.longitude == reminder.location.latitude) && (mapOverlay.coordinate.latitude == reminder.location.longitude)){
            hasCurrentAnnotation = YES;
            }
        }
        if (!hasCurrentAnnotation) {
            CGFloat radius = [[reminder radius] floatValue];
            CLLocationCoordinate2DMake(reminder.location.latitude, reminder.location.longitude);
            MKCircle *overlayCircle = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(reminder.location.latitude, reminder.location.longitude) radius:radius];
            [self.mapView addOverlay:overlayCircle];
    }
}


@end
