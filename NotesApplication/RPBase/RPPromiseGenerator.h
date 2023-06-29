//
//  RPPromiseGenerator.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;
@import PromiseKit;
#import "RPDataProvider.h"
#import "RPNote.h"

@interface RPPromiseGenerator: NSObject

@property (nullable, nonatomic, weak, readonly) id<RPDataProvider> dataProvider;

-(instancetype _Nullable)initWithDataProvider:(id<RPDataProvider> _Nonnull)dataProvider;
-(AnyPromise* _Nonnull)promiseToGetAllNotes;
-(AnyPromise* _Nonnull)promiseToGetNoteForID:(NOTE_ID)nodeID;
-(AnyPromise* _Nonnull)promiseToAddNote:(RPNote* _Nonnull)note;
-(AnyPromise* _Nonnull)promiseToEditNote:(RPNote* _Nonnull)note;
-(AnyPromise* _Nonnull)promiseToDeleteNote:(RPNote* _Nonnull)note;
-(AnyPromise* _Nonnull)promiseToGetAllLocales;

@end
