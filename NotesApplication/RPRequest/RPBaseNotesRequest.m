//
//  RPBaseNotesRequest.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPBaseNotesRequest.h"

NSString* const NOTES_PATH_BEGIN = @"todos";

@implementation RPBaseNotesRequest

-(RequestPath)urlPath {
    return @[NOTES_PATH_BEGIN];
}

@end
