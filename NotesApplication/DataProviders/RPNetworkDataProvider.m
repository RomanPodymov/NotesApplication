//
//  RPNetworkDataProvider.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPNetworkDataProvider.h"
#import "RPNotesRequest.h"
#import "RPGetNoteRequest.h"
#import "RPAddNoteRequest.h"
#import "RPEditNoteRequest.h"
#import "RPDeleteNoteRequest.h"
#import "RPCustomization.h"
#import "RPNetworkConnectable.h"
#import "AFNetworkingConnector.h"

#define CONNECTION_CLASS AFNetworkingConnector

#define GENERIC_REQUEST_HANDLER ^(id responseObject, NSError* responseError) { \
    if (responseError == nil) { \
        handler([request parseRequestResult:responseObject], nil); \
    } else { \
        handler(nil, responseError); \
    } \
}

NSString* const SCHEME_AND_HOST_BORDER = @"://";

typedef NS_ENUM(NSUInteger, URL_SCHEME) {
    SCHEME_HTTP,
    SCHEME_HTTPS,
    SCHEME_UNKNOWN
};

NSString* const SCHEME_HTTP_STRING = @"http";
NSString* const SCHEME_HTTPS_STRING = @"https";

NSString* const ERROR_NETWORK_PROVIDER_LOAD_NOTE_WITH_ID_NOT_IMPLEMENTED = @"RPNetworkDataProvider.loadNoteWithID is not implemented";
NSString* const ERROR_NETWORK_PROVIDER_LOAD_LOCALES_NOT_IMPLEMENTED = @"RPNetworkDataProvider.loadLocalesListWithHandler is not implemented";

@interface RPNetworkDataProvider()

@property (nonnull, nonatomic, strong, readonly) id<RPNetworkConnectable> networkConnection;
@property (nonatomic, readonly) URL_SCHEME scheme;
@property (nullable, nonatomic, strong, readonly) NSString* host;

@end

@implementation RPNetworkDataProvider

- (instancetype)init {
    self = [super init];
    if (self) {
        _networkConnection = [CONNECTION_CLASS new];
        [_networkConnection prepare];
        _scheme = [self stringToScheme:[RPCustomization sharedInstance].networkDataSource.scheme];
        _host = [RPCustomization sharedInstance].networkDataSource.host;
    }
    return self;
}

-(URL_SCHEME)stringToScheme:(NSString*)str {
    if ([str isEqualToString:SCHEME_HTTP_STRING]) {
        return SCHEME_HTTP;
    } else if ([str isEqualToString:SCHEME_HTTPS_STRING]) {
        return SCHEME_HTTPS;
    }
    return SCHEME_UNKNOWN;
}

-(NSString* _Nullable)schemeToString:(URL_SCHEME)scheme {
    switch (scheme) {
        case SCHEME_HTTP:
            return SCHEME_HTTP_STRING;
            break;
        case SCHEME_HTTPS:
            return SCHEME_HTTPS_STRING;
            break;
        case SCHEME_UNKNOWN:
            return nil;
            break;
    }
    return nil;
}

-(NSString* _Nonnull)schemeAndHost {
    NSString* _Nullable schemeAsStringValue = [self schemeToString:_scheme];
    if (schemeAsStringValue != nil && _host != nil) {
        return [@[schemeAsStringValue, _host] componentsJoinedByString:SCHEME_AND_HOST_BORDER];
    }
    return [NSString new];
}

@end

@implementation RPNetworkDataProvider (RPDataProviderStuff)

-(void)loadNotesListWithHandler:(NotesListLoaderHandler)handler {
    [self makeRequestAndParse:[RPNotesRequest new] handler:handler];
}

-(void)loadNoteWithID:(NOTE_ID)noteId  handler:(NoteLoaderHandler)handler {
    [self makeRequestAndParse:[[RPGetNoteRequest alloc] initWithNote:[[RPNote alloc] initWithId:noteId]]
                                                             handler:handler];
}

-(void)addNote:(RPNote* _Nonnull)note handler:(NoteLoaderHandler)handler {
    [self makeRequestAndParse:[[RPAddNoteRequest alloc] initWithNote:note] handler:handler];
}

-(void)editNote:(RPNote* _Nonnull)note handler:(NoteLoaderHandler)handler {
    [self makeRequestAndParse:[[RPEditNoteRequest alloc] initWithNote:note] handler:handler];
}

-(void)deleteNote:(RPNote* _Nonnull)note handler:(NoteLoaderHandler)handler {
    [self makeRequestAndParse:[[RPDeleteNoteRequest alloc] initWithNote:note] handler:handler];
}

-(void)loadLocalesListWithHandler:(LocalesListLoaderHandler)handler {
    NSAssert(NO, ERROR_NETWORK_PROVIDER_LOAD_LOCALES_NOT_IMPLEMENTED);
}

#pragma mark utilities

-(void)makeRequestAndParse:(RPBaseRequest* _Nonnull)request handler:(BaseHandler)handler {
    NSURLComponents* components = [[NSURLComponents alloc] initWithString:[self schemeAndHost]];
    components.path = [request pathAsString];
    switch (request.method) {
        case METHOD_GET:
            [self makeGetRequestAndParse:components.URL request:request handler:handler];
            break;
        case METHOD_POST:
            [self makePostRequestAndParse:components.URL request:request handler:handler];
            break;
        case METHOD_DELETE:
            [self makeDeleteRequestAndParse:components.URL request:request handler:handler];
            break;
        case METHOD_PUT:
            [self makePutRequestAndParse:components.URL request:request handler:handler];
            break;
    }
}

-(void)makeGetRequestAndParse:(NSURL*)url request:(RPBaseRequest* _Nonnull)request handler:(BaseHandler)handler {
    [_networkConnection makeGETforURL:url.absoluteString handler:GENERIC_REQUEST_HANDLER];
}

-(void)makePostRequestAndParse:(NSURL*)url request:(RPBaseRequest* _Nonnull)request handler:(BaseHandler)handler {
    [_networkConnection makePOSTforURL:url.absoluteString
                            parameters:request.dataForPOST
                               handler:GENERIC_REQUEST_HANDLER];
}

-(void)makeDeleteRequestAndParse:(NSURL*)url request:(RPBaseRequest* _Nonnull)request handler:(BaseHandler)handler {
    [_networkConnection makeDELETEforURL:url.absoluteString handler:GENERIC_REQUEST_HANDLER];
}

-(void)makePutRequestAndParse:(NSURL*)url request:(RPBaseRequest* _Nonnull)request handler:(BaseHandler)handler {
    [_networkConnection makePUTforURL:url.absoluteString
                           parameters:request.dataForPOST
                              handler:GENERIC_REQUEST_HANDLER];
}

@end
