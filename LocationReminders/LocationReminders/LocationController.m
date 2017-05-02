//
//  LocationController.m
//  LocationReminders
//
//  Created by Eve Denison on 5/2/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "LocationController.h"

#import "ViewController.h"


@implementation LocationController

+(LocationController *)sharedInstance {
    static LocationController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LocationController alloc]init];
    
    });
    
    return sharedInstance;

}

@end
