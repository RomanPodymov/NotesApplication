//
//  RPLocalizationMaster.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;
#import "RPLocale.h"
#import "RPUtilities.h"

extern NSString* _Nonnull const TRANSLATION_KEY_EMPTY_DATA;
extern NSString* _Nonnull const TRANSLATION_KEY_ERROR_GET_DATA;
extern NSString* _Nonnull const TRANSLATION_KEY_BAR_LANGUAGES;
extern NSString* _Nonnull const TRANSLATION_KEY_BAR_ADD;
extern NSString* _Nonnull const TRANSLATION_KEY_BAR_BACK;
extern NSString* _Nonnull const TRANSLATION_KEY_BAR_SAVE;
extern NSString* _Nonnull const TRANSLATION_KEY_BAR_MORE;
extern NSString* _Nonnull const TRANSLATION_KEY_ERROR;
extern NSString* _Nonnull const TRANSLATION_KEY_MESSAGE;
extern NSString* _Nonnull const TRANSLATION_KEY_CANNOT_ADD_NOTE;
extern NSString* _Nonnull const TRANSLATION_KEY_CANNOT_EDIT_NOTE;
extern NSString* _Nonnull const TRANSLATION_KEY_CANNOT_DELETE_NOTE;
extern NSString* _Nonnull const TRANSLATION_KEY_ADD_NOTE_OK;
extern NSString* _Nonnull const TRANSLATION_KEY_EDIT_NOTE_OK;
extern NSString* _Nonnull const TRANSLATION_KEY_DELETE_NOTE_OK;
extern NSString* _Nonnull const TRANSLATION_KEY_BTN_OK;
extern NSString* _Nonnull const TRANSLATION_KEY_BTN_CANCEL;
extern NSString* _Nonnull const TRANSLATION_KEY_BTN_EDIT;
extern NSString* _Nonnull const TRANSLATION_KEY_BTN_DELETE;

#define ALL_TRANSLATION_KEYS @[ \
    TRANSLATION_KEY_EMPTY_DATA, \
    TRANSLATION_KEY_ERROR_GET_DATA, \
    TRANSLATION_KEY_BAR_LANGUAGES, \
    TRANSLATION_KEY_BAR_ADD, \
    TRANSLATION_KEY_BAR_BACK, \
    TRANSLATION_KEY_BAR_SAVE, \
    TRANSLATION_KEY_BAR_MORE, \
    TRANSLATION_KEY_ERROR, \
    TRANSLATION_KEY_MESSAGE, \
    TRANSLATION_KEY_CANNOT_ADD_NOTE, \
    TRANSLATION_KEY_CANNOT_EDIT_NOTE, \
    TRANSLATION_KEY_CANNOT_DELETE_NOTE, \
    TRANSLATION_KEY_ADD_NOTE_OK, \
    TRANSLATION_KEY_EDIT_NOTE_OK, \
    TRANSLATION_KEY_DELETE_NOTE_OK, \
    TRANSLATION_KEY_BTN_OK, \
    TRANSLATION_KEY_BTN_CANCEL, \
    TRANSLATION_KEY_BTN_EDIT, \
    TRANSLATION_KEY_BTN_DELETE \
]

extern NSNotificationName _Nonnull const NOTIFICATION_LANGUAGE_CHANGED;
extern NSString* _Nonnull const NOTIFICATION_KEY_CURRENT_LOCALE;

@interface RPLocalizationMaster: NSObject

SHARED_CLASS()

-(void)setupCurrentLocaleID:(LOCALE_ID* _Nullable)localeID;
-(NSString* _Nonnull)translate:(NSString* _Nonnull)key;

@property (nonnull, nonatomic, strong, readonly) NSArray<RPLocale*>* locales;

@end

@protocol RPLocalizable

-(void)onLocaleChanged:(LOCALE_ID* _Nonnull)nextLocale;

@end
