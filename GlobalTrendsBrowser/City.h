//
//  City.h
//  GlobalTrendsBrowser
//
//  Created by Kadir Yazgan on 06/12/14.
//  Copyright (c) 2014 KY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface City : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSNumber * woeid;

@end
