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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestPermissions];
    self.mapView.showsUserLocation = YES;
    
}

//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//
//    testObject[@"testName"] = @"Eve Denison";
//
//    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if succeeded {
//            NSLog(@"Success in saving test obejct.");
//        }else {
//            NSLog(@"There was a problem saving.  Save Error: %@",  error.localizedDescription);    
//        }
//
//    }];
//
//    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
//
//[query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable orror) {
//    if (error) {
//        NSLog(@"%@", error.localizedDescription);
//    }else {
//        NSLog(@"Query results %@", objects);
//    }
//
//})];


-(void)requestPermissions {
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager requestAlwaysAuthorization];

}


- (IBAction)location1ButtonPressed:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6566674, -122.351096);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.00, 500.00);
    
    [self.mapView setRegion:region animated:YES];

}
- (IBAction)location2ButtonPressed:(id)sender {
}

- (IBAction)location3ButtonPressed:(id)sender {
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
