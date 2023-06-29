//
//  RPNetworkConnectable.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;

typedef void(^GenericRequestHandler)(id _Nullable, NSError* _Nullable);

@protocol RPNetworkConnectable

-(void)prepare;
-(void)makeGETforURL:(NSString* _Nonnull)url handler:(GenericRequestHandler _Nonnull)handler;
-(void)makePOSTforURL:(NSString* _Nonnull)url parameters:(NSDictionary* _Nullable)parameters handler:(GenericRequestHandler _Nonnull)handler;
-(void)makeDELETEforURL:(NSString* _Nonnull)url handler:(GenericRequestHandler _Nonnull)handler;
-(void)makePUTforURL:(NSString* _Nonnull)url parameters:(NSDictionary* _Nullable)parameters handler:(GenericRequestHandler _Nonnull)handler;

@end
