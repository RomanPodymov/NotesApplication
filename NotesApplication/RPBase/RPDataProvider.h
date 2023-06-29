//
//  RPDataProvider.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;
#import "RPNote.h"
#import "RPLocale.h"

@protocol RPDataProvider

typedef void(^BaseHandler)(id _Nullable, NSError* _Nullable);
typedef void(^NotesListLoaderHandler)(RPNotesList* _Nullable, NSError* _Nullable);
typedef void(^NoteLoaderHandler)(RPNote* _Nullable, NSError* _Nullable);
typedef void(^LocalesListLoaderHandler)(RPLocalesList* _Nullable, NSError* _Nullable);

-(void)loadNotesListWithHandler:(NotesListLoaderHandler _Nonnull)handler;
-(void)loadNoteWithID:(NOTE_ID)noteId  handler:(NoteLoaderHandler _Nonnull)handler;
-(void)addNote:(RPNote* _Nonnull)note handler:(NoteLoaderHandler _Nonnull)handler;
-(void)editNote:(RPNote* _Nonnull)note handler:(NoteLoaderHandler _Nonnull)handler;
-(void)deleteNote:(RPNote* _Nonnull)note handler:(NoteLoaderHandler _Nonnull)handler;
-(void)loadLocalesListWithHandler:(LocalesListLoaderHandler _Nonnull)handler;

@end
