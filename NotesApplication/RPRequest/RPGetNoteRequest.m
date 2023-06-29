//
//  RPGetNoteRequest.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPGetNoteRequest.h"

@implementation RPGetNoteRequest

-(RequestPath)urlPath {
    return [[super urlPath] arrayByAddingObject:@(self.note.idValue).stringValue];
}

@end
