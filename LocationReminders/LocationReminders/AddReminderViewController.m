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
    
    UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc]init]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(savePressedDismissReminderViewController)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
}

-(void)savePressedDismissReminderViewController {
    
    [self saveNewReminder];
    [[self navigationController] popViewControllerAnimated:YES];
    
}

-(void)saveNewReminder {
    
    Reminder *newReminder = [Reminder object];
    
    newReminder.reminderName = self.reminderNameTextField.text;
    newReminder.radius = [self numberFromString:self.radiusTextField.text];
    
    newReminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    [newReminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {

        NSLog(@"Save reminder sucessful:%i - Error: %@", succeeded,error.localizedDescription);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderSavedToParse" object:nil];
        
        if (self.completion) {
            
            CGFloat radius = [self.radiusTextField.text floatValue];
            
            MKCircle *circle = [MKCircle circleWithCenterCoordinate:self.coordinate radius:radius];
            
            //Execute block
            self.completion(circle);
            [self.navigationController popViewControllerAnimated:YES];

        }
    }];

}

-(NSNumber *)numberFromString:(NSString *)string {
    NSNumberFormatter *formatString = [[NSNumberFormatter alloc]init];
    [formatString setNumberStyle:NSNumberFormatterDecimalStyle];
    return  [formatString numberFromString:string];
}

@end
