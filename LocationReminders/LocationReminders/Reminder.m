//
//  Reminder.m
//  LocationReminders
//
//  Created by Eve Denison on 5/3/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

@dynamic reminderName;
@dynamic location;
@dynamic radius;

+(void)load {
    [super load];
    [self registerSubclass];

}

+(NSString *)parseClassName {
    return @"Reminder";
    
}

@end
