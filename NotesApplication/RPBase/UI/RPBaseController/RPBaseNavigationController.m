//
//  RPBaseNavigationController.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPBaseNavigationController.h"

@interface RPBaseNavigationController ()

@end

@implementation RPBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self observeLocaleChanges];
    [self setupStyles];
    [self customize];
    [self.view setNeedsUpdateConstraints];
}

@end

@implementation RPBaseNavigationController (RPLocalizableStuff)

-(void)onLocaleChanged:(NSString *)nextLocale {
    
}

@end

@implementation RPBaseNavigationController (RPCustomizableStuff)

-(void)customize {
    
}

@end

@implementation RPBaseNavigationController (RPStyleableStuff)

-(void)setupStyles {
    
}

@end
