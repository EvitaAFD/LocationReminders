//
//  AddReminderViewController.m
//  LocationReminders
//
//  Created by Eve Denison on 5/2/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "AddReminderViewController.h"

@interface AddReminderViewController ()

@property (weak, nonatomic) IBOutlet UITextField *reminderNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *radiusTextField;

@end

@implementation AddReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Annotation Title: %@", self.annotationTitle);
    NSLog(@"Coordinates: Latitude %f, Longitude %f", self.coordinate.latitude, self.coordinate.longitude);
    
    UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc]init]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(dismissReminderViewController)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
}

-(void)dismissReminderViewController {
    [[self navigationController] popViewControllerAnimated:YES];

}

@end
