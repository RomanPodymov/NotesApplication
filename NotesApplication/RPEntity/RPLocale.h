//
//  RPLocale.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;
#import "RPBaseEntity.h"

@class RPLocale;
typedef NSArray<RPLocale*> RPLocalesList;
#define LOCALE_ID NSString

@interface RPLocale: RPBaseEntity

-(instancetype _Nullable)initWithLocaleID:(LOCALE_ID* _Nonnull)localeID localeTitle:(NSString* _Nonnull)localeTitle;

@property (nonnull, nonatomic, strong, readonly) LOCALE_ID* localeID;
@property (nonnull, nonatomic, strong, readonly) NSString* localeTitle;

@end
