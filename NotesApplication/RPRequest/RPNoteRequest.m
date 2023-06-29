//
//  RPNoteRequest.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPNoteRequest.h"

@interface RPNoteRequest()

@end

@implementation RPNoteRequest

-(instancetype)initWithNote:(RPNote*)note {
    self = [super init];
    if (self) {
        _note = note;
    }
    return self;
}

-(RPNote* _Nullable)parseRequestResult:(id _Nullable)requestResult {
    if (requestResult != nil && [requestResult isKindOfClass:[NSDictionary class]]) {
        NSError* error;
        RPNote* result = [[RPNote alloc] initWithDictionary:requestResult error:&error];
        return result;
    } else {
        return nil;
    }
}

@end
