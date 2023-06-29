//
//  RPEditNoteRequest.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPEditNoteRequest.h"

@implementation RPEditNoteRequest

-(REQUEST_METHOD)method {
    return METHOD_PUT;
}

-(NSDictionary* _Nullable)dataForPOST {
    return @{JSON_KEY_TITLE: self.note.title};
}

@end
