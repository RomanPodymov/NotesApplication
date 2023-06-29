//
//  RPNoteRequest.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;
#import "RPBaseNotesRequest.h"
#import "RPNote.h"

@interface RPNoteRequest: RPBaseNotesRequest<RPNote*>

@property (nonnull, nonatomic, strong, readonly) RPNote* note;
-(instancetype _Nullable)initWithNote:(RPNote* _Nonnull)note;

@end
