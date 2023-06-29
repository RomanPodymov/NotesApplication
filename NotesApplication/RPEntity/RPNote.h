//
//  RPNote.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;
#import "RPBaseEntity.h"

extern NSInteger const UNDEFINED_ID;

@class RPNote;
typedef NSArray<RPNote*> RPNotesList;

#define NOTE_ID NSInteger
#define NOTE_NAME NSString

@interface RPNote: RPBaseEntity

-(instancetype _Nullable)initWithId:(NOTE_ID)idValue title:(NOTE_NAME* _Nonnull)title;
-(instancetype _Nullable)initWithId:(NOTE_ID)idValue;
-(instancetype _Nullable)initWithTitle:(NOTE_NAME* _Nonnull)title;
-(RPNote* _Nonnull)withUpdatedTitle:(NSString* _Nonnull)title;

@property (nonatomic) NOTE_ID idValue;
@property (nonatomic, nonnull) NOTE_NAME <Optional>* title;

@end
