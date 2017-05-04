//
//  Reminder.h
//  LocationReminders
//
//  Created by Eve Denison on 5/3/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import <Parse/Parse.h>

@interface Reminder : PFObject <PFSubclassing>


@property(strong, nonatomic) NSString *reminderName;
@property(strong,nonatomic) PFGeoPoint *location;
@property(strong, nonatomic) NSNumber *radius;

@end
