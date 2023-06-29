//
//  RPLocalizationMaster.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import XMLDictionary;
@import BlocksKit;
#import "RPLocalizationMaster.h"
#import "RPPreferences.h"

NSString* const LOCALIZATION_RESOURCES_EXT = @"lproj";
NSString* const TRANSLATIONS_FILE_NAME = @"translations";
NSString* const TRANSLATIONS_FILE_EXT = @"xml";
NSString* const TRANSLATIONS_KEY_STRING = @"string";
NSString* const TRANSLATIONS_KEY_NAME = @"_name";
NSString* const TRANSLATIONS_KEY_TEXT = @"__text";

NSNotificationName const NOTIFICATION_LANGUAGE_CHANGED = @"NOTIFICATION_LANGUAGE_CHANGED";
NSString* const NOTIFICATION_KEY_CURRENT_LOCALE = @"NOTIFICATION_KEY_CURRENT_LOCALE";

LOCALE_ID* const LANGUAGE_ENGLISH_ID = @"en";
LOCALE_ID* const LANGUAGE_RUSSIAN_ID = @"ru";

NSString* const LANGUAGE_ENGLISH_TITLE = @"English";
NSString* const LANGUAGE_RUSSIAN_TITLE = @"Русский";

NSString* const TRANSLATION_KEY_EMPTY_DATA = @"message_empty_data";
NSString* const TRANSLATION_KEY_ERROR_GET_DATA = @"message_error_get_data";
NSString* const TRANSLATION_KEY_BAR_LANGUAGES = @"bar_languages";
NSString* const TRANSLATION_KEY_BAR_ADD = @"bar_add";
NSString* const TRANSLATION_KEY_BAR_BACK = @"bar_back";
NSString* const TRANSLATION_KEY_BAR_SAVE = @"bar_save";
NSString* const TRANSLATION_KEY_BAR_MORE = @"bar_more";
NSString* const TRANSLATION_KEY_ERROR = @"error";
NSString* const TRANSLATION_KEY_MESSAGE = @"message";
NSString* const TRANSLATION_KEY_CANNOT_ADD_NOTE = @"cannot_add_note";
NSString* const TRANSLATION_KEY_CANNOT_EDIT_NOTE = @"cannot_edit_note";
NSString* const TRANSLATION_KEY_CANNOT_DELETE_NOTE = @"cannot_delete_note";
NSString* const TRANSLATION_KEY_ADD_NOTE_OK = @"add_note_ok";
NSString* const TRANSLATION_KEY_EDIT_NOTE_OK = @"edit_note_ok";
NSString* const TRANSLATION_KEY_DELETE_NOTE_OK = @"delete_note_ok";
NSString* const TRANSLATION_KEY_BTN_OK = @"btn_ok";
NSString* const TRANSLATION_KEY_BTN_CANCEL = @"btn_cancel";
NSString* const TRANSLATION_KEY_BTN_EDIT = @"btn_edit";
NSString* const TRANSLATION_KEY_BTN_DELETE = @"btn_delete";

@interface RPLocalizationMaster()

@property (nonnull, nonatomic, strong, readonly) NSBundle* currentBundle;
@property (nonnull, nonatomic, strong, readonly) NSDictionary* currentXMLFile;
@property (nonnull, nonatomic, strong, readonly) NSArray* currentXMLstrings;

@end

@implementation RPLocalizationMaster

MAKE_SHARED(RPLocalizationMaster)

- (instancetype)init {
    self = [super init];
    if (self) {
        _locales = @[
            [[RPLocale alloc] initWithLocaleID:LANGUAGE_ENGLISH_ID localeTitle:LANGUAGE_ENGLISH_TITLE],
            [[RPLocale alloc] initWithLocaleID:LANGUAGE_RUSSIAN_ID localeTitle:LANGUAGE_RUSSIAN_TITLE],
        ];
        if (RPPreferences.sharedInstance.selectedLocale == nil) {
            [self setupCurrentLocaleID:[self defaultLocaleID]];
        } else {
            [self setupCurrentLocaleID:nil];
        }
    }
    return self;
}

-(void)setupCurrentLocaleID:(LOCALE_ID* _Nullable)localeID {
    if (localeID != nil) {
        RPPreferences.sharedInstance.selectedLocale = localeID;
        [RPPreferences.sharedInstance synchronize];
    }
    [self createCurrentBundle];
    [self reloadTranslations];
    LOCALE_ID* currentLocaleID = localeID == nil ? RPPreferences.sharedInstance.selectedLocale : localeID;
    [NSNotificationCenter.defaultCenter postNotificationName:NOTIFICATION_LANGUAGE_CHANGED
                                                      object:nil
                                                    userInfo:@{NOTIFICATION_KEY_CURRENT_LOCALE:currentLocaleID}];
}

-(void)createCurrentBundle {
    NSString* pathToBundle = [NSBundle.mainBundle pathForResource:RPPreferences.sharedInstance.selectedLocale
                                                           ofType:LOCALIZATION_RESOURCES_EXT];
    _currentBundle = [NSBundle bundleWithPath:pathToBundle];
}

-(void)reloadTranslations {
    NSString *filePath = [_currentBundle pathForResource:TRANSLATIONS_FILE_NAME
                                                  ofType:TRANSLATIONS_FILE_EXT];
    _currentXMLFile = [NSDictionary dictionaryWithXMLFile:filePath];
    _currentXMLstrings = [_currentXMLFile objectForKey:TRANSLATIONS_KEY_STRING];
}

-(NSString* _Nonnull)translate:(NSString*)key {
    id matchingItem = [_currentXMLstrings bk_match:^BOOL(id currentTranslation) {
        NSString* translationKey = [RPLocalizationMaster extractDataFromTranslation:currentTranslation
                                 field:TRANSLATIONS_KEY_NAME];
        if (translationKey != nil) {
            return [translationKey isEqualToString:key];
        }
        return NO;
    }];
    if (matchingItem != nil) {
        NSString* translationValue = [RPLocalizationMaster extractDataFromTranslation:matchingItem
                                                                                field:TRANSLATIONS_KEY_TEXT];
        return translationValue == nil ? [NSString new] : translationValue;
    }
    return [NSString new];
}

+(NSString* _Nullable)extractDataFromTranslation:(id)translation field:(NSString*)field {
    if ([translation isKindOfClass:[NSDictionary class]]) {
        id translationField = [((NSDictionary*)translation) objectForKey:field];
        if ([translationField isKindOfClass:[NSString class]]) {
            return (NSString*)translationField;
        }
    }
    return nil;
}

-(LOCALE_ID*)defaultLocaleID {
    NSLocale *locale = NSLocale.currentLocale;
    NSString *languageCode = [locale objectForKey:NSLocaleLanguageCode];
    RPLocale* applicationLocale = [_locales bk_match:^BOOL(RPLocale* currentLocaleObj) {
        return [currentLocaleObj.localeID isEqualToString:languageCode];
    }];
    if (applicationLocale != nil) {
        return applicationLocale.localeID;
    }
    return LANGUAGE_ENGLISH_ID;
}

@end
