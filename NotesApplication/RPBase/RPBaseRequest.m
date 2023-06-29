//
//  RPBaseRequest.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPBaseRequest.h"

NSString* const PATH_JOINED_STRING = @"/";

NSString* const ERROR_OVERRIDE_PARSE_REQUEST_RESULT = @"You must override RPBaseRequest.parseRequestResult in a subclass";
NSString* const ERROR_OVERRIDE_URL_PATH = @"You must override RPBaseRequest.urlPath in a subclass";

@implementation RPBaseRequest

-(RPNotesList* _Nullable)parseRequestResult:(id _Nullable)requestResult {
    NSAssert(NO, ERROR_OVERRIDE_PARSE_REQUEST_RESULT);
    return nil;
}

-(RequestPath)urlPath {
    NSAssert(NO, ERROR_OVERRIDE_URL_PATH);
    return @[];
}

-(REQUEST_METHOD)method {
    return METHOD_GET;
}

-(NSString* _Nonnull)pathAsString {
    return [PATH_JOINED_STRING stringByAppendingString:[[self urlPath] componentsJoinedByString:PATH_JOINED_STRING]];
}

-(NSDictionary* _Nullable)dataForPOST {
    return nil;
}

@end
