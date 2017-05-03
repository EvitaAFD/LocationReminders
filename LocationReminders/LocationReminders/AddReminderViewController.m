//
//  AddReminderViewController.m
//  LocationReminders
//
//  Created by Eve Denison on 5/2/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "AddReminderViewController.h"

#import "Reminder.h"

@interface AddReminderViewController ()

@property (weak, nonatomic) IBOutlet UITextField *reminderNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *radiusTextField;

@end

@implementation AddReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Reminder *newReminder = [Reminder object];
    
    newReminder.reminderName = self.annotationTitle;
    
    newReminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    [newReminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"Annotation Title: %@", self.annotationTitle);
        NSLog(@"Coordinates: Latitude %f, Longitude %f", self.coordinate.latitude, self.coordinate.longitude);
        NSLog(@"Save reminder sucessful:%i - Error: %@", succeeded,error.localizedDescription);
        
        if (self.completion) {
            
            CGFloat radius = 100; //lab coming from UISlider
            
            MKCircle *circle = [MKCircle circleWithCenterCoordinate:self.coordinate radius:radius];
            
            self.completion(circle);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    
    
    
    UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc]init]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(dismissReminderViewController)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
}

-(void)dismissReminderViewController {
    [[self navigationController] popViewControllerAnimated:YES];

}

@end
