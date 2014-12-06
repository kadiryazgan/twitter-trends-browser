//
//  Country.h
//  GlobalTrendsBrowser
//
//  Created by Kadir Yazgan on 06/12/14.
//  Copyright (c) 2014 KY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Country : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * name;

@end
