//
//  RPPreferencesDataProvider.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPPreferencesDataProvider.h"
#import "RPLocalizationMaster.h"

NSString* const ERROR_PREFERENCES_PROVIDER_LOAD_NOTES_NOT_IMPLEMENTED = @"RPPreferencesDataProvider.loadNotesListWithHandler is not implemented";
NSString* const ERROR_PREFERENCES_PROVIDER_LOAD_NOTE_WITH_ID_NOT_IMPLEMENTED = @"RPPreferencesDataProvider.loadNoteWithID is not implemented";
NSString* const ERROR_PREFERENCES_PROVIDER_ADD_NOTE_NOT_IMPLEMENTED = @"RPPreferencesDataProvider.addNote is not implemented";
NSString* const ERROR_PREFERENCES_PROVIDER_EDIT_NOTE_NOT_IMPLEMENTED = @"RPPreferencesDataProvider.editNote is not implemented";
NSString* const ERROR_PREFERENCES_PROVIDER_DELETE_NOTE_NOT_IMPLEMENTED = @"RPPreferencesDataProvider.deleteNote is not implemented";

@implementation RPPreferencesDataProvider

@end

@implementation RPPreferencesDataProvider (RPDataProviderStuff)

-(void)loadNotesListWithHandler:(NotesListLoaderHandler)handler {
    NSAssert(NO, ERROR_PREFERENCES_PROVIDER_LOAD_NOTES_NOT_IMPLEMENTED);
}

-(void)loadNoteWithID:(NOTE_ID)noteId  handler:(NoteLoaderHandler)handler {
    NSAssert(NO, ERROR_PREFERENCES_PROVIDER_LOAD_NOTE_WITH_ID_NOT_IMPLEMENTED);
}

-(void)addNote:(RPNote* _Nonnull)note handler:(NoteLoaderHandler)handler {
    NSAssert(NO, ERROR_PREFERENCES_PROVIDER_ADD_NOTE_NOT_IMPLEMENTED);
}

-(void)editNote:(RPNote* _Nonnull)note handler:(NoteLoaderHandler)handler {
    NSAssert(NO, ERROR_PREFERENCES_PROVIDER_EDIT_NOTE_NOT_IMPLEMENTED);
}

-(void)deleteNote:(RPNote* _Nonnull)note handler:(NoteLoaderHandler)handler {
    NSAssert(NO, ERROR_PREFERENCES_PROVIDER_DELETE_NOTE_NOT_IMPLEMENTED);
}

-(void)loadLocalesListWithHandler:(LocalesListLoaderHandler)handler {
    handler(RPLocalizationMaster.sharedInstance.locales, nil);
}

@end
