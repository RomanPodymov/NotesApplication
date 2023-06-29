//
//  RPAddNoteRequest.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPAddNoteRequest.h"

@interface RPAddNoteRequest()

@end

@implementation RPAddNoteRequest

-(RequestPath)urlPath {
    return @[NOTES_PATH_BEGIN];
}

-(REQUEST_METHOD)method {
    return METHOD_POST;
}

-(NSDictionary* _Nullable)dataForPOST {
    return @{JSON_KEY_TITLE: self.note.title};
}

@end
