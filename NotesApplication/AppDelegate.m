//
//  AppDelegate.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "AppDelegate.h"
#import "RPLocalizationMaster.h"
#import "RPNotesNavigationController.h"
#import "RPNotesListViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [RPLocalizationMaster sharedInstance];
    
    _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    RPNotesListViewController* notesListViewController = [RPNotesListViewController new];
    RPNotesNavigationController* notesNavigationController = [[RPNotesNavigationController alloc] initWithRootViewController:notesListViewController];
    _window.rootViewController = notesNavigationController;
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
