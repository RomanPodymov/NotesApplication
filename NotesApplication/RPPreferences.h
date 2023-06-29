//
//  RPPreferences.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;
#import "PAPreferences.h"
#import "RPLocale.h"

@interface RPPreferences: PAPreferences

@property (nonatomic, assign) LOCALE_ID* selectedLocale;

@end
