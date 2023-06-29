//
//  RPNotesRequest.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPNotesRequest.h"
#import "BlocksKit.h"

@implementation RPNotesRequest

-(RPNotesList* _Nullable)parseRequestResult:(id _Nullable)requestResult {
    if (requestResult != nil && [requestResult isKindOfClass:[NSArray class]]) {
        RPNotesList* notesList = [((NSArray*)requestResult) bk_map:^RPNote*(id responseObjectItem) {
            NSError* error;
            RPNote* result = [[RPNote alloc] initWithDictionary:responseObjectItem error:&error];
            return result;
        }];
        return notesList;
    } else {
        return nil;
    }
}

@end
