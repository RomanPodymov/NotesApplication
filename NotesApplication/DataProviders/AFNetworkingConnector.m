//
//  AFNetworkingConnector.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "AFNetworkingConnector.h"
@import AFNetworking;

#define SESSION_MANAGER_REQUEST(METHOD_NAME, URL_VALUE, PARAMS, HANDLER) \
    [_sessionManager METHOD_NAME:URL_VALUE parameters:PARAMS headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { \
        HANDLER(responseObject, nil); \
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { \
        HANDLER(nil, error); \
    }];

#define SESSION_MANAGER_REQUEST_WITH_PROGRESS(METHOD_NAME, URL_VALUE, PARAMS, HANDLER) \
    [_sessionManager METHOD_NAME:URL_VALUE parameters:PARAMS headers:nil progress:^(NSProgress* _Nonnull downloadProgress) { \
    } success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) { \
        HANDLER(responseObject, nil); \
    } failure:^(NSURLSessionDataTask* _Nullable task, NSError * _Nonnull error) { \
        HANDLER(nil, error); \
    }];

@interface AFNetworkingConnector ()

@property (nonnull, nonatomic, strong, readonly) AFHTTPSessionManager *sessionManager;

@end

@implementation AFNetworkingConnector

@end

@implementation AFNetworkingConnector (RPNetworkConnectableStuff)

-(void)prepare {
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.completionQueue = dispatch_get_global_queue(QOS_CLASS_UTILITY, 0);
}

-(void)makeGETforURL:(NSString* _Nonnull)url handler:(GenericRequestHandler)handler {
    SESSION_MANAGER_REQUEST_WITH_PROGRESS(GET, url, nil, handler)
}

-(void)makePOSTforURL:(NSString* _Nonnull)url parameters:(NSDictionary* _Nullable)parameters handler:(GenericRequestHandler)handler {
    SESSION_MANAGER_REQUEST_WITH_PROGRESS(POST, url, parameters, handler)
}

-(void)makeDELETEforURL:(NSString* _Nonnull)url handler:(GenericRequestHandler)handler {    
    SESSION_MANAGER_REQUEST(DELETE, url, nil, handler)
}

-(void)makePUTforURL:(NSString* _Nonnull)url parameters:(NSDictionary* _Nullable)parameters handler:(GenericRequestHandler)handler {
    SESSION_MANAGER_REQUEST(PUT, url, parameters, handler)
}

@end
