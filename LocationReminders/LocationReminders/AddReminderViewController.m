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
    
    UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc]init]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(dismissReminderViewController)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
}

-(void)savePressedDismissReminderViewController {
    
    [self saveNewReminder];
    [[self navigationController] popViewControllerAnimated:YES];
    
}

-(void)saveNewReminder {
    
    Reminder *newReminder = [Reminder object];
    
    newReminder.reminderName = self.annotationTitle;
    
    newReminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    [newReminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"Annotation Title: %@", self.annotationTitle);
        NSLog(@"Coordinates: Latitude %f, Longitude %f", self.coordinate.latitude, self.coordinate.longitude);
        NSLog(@"Save reminder sucessful:%i - Error: %@", succeeded,error.localizedDescription);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderSavedToParse" object:nil];
        
        if (self.completion) {
            
            NSString *reminderName = self.reminderNameTextField.text;
            
            CGFloat radius = [self.radiusTextField.text floatValue];
            
            MKCircle *circle = [MKCircle circleWithCenterCoordinate:self.coordinate radius:radius];
            
            //Execute block
            self.completion(circle);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];

}

@end
