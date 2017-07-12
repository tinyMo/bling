//
//  AppDelegate.h
//  bling
//
//  Created by 楼 彬 on 17/6/6.
//  Copyright (c) 2017年 lb1006. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) UINavigationController *navController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

