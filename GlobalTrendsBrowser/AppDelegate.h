//
//  AppDelegate.h
//  GlobalTrendsBrowser
//
//  Created by Kadir Yazgan on 06/12/14.
//  Copyright (c) 2014 Kadir Yazgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <STTwitter/STTwitterAPI.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) STTwitterAPI *twitter;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

