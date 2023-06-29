//
//  RPBaseRequest.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;
#import "RPBaseEntity.h"
#import "RPNetworkDataProvider.h"

typedef NSArray<NSString*>* _Nullable RequestPath;

@interface RPBaseRequest<__covariant ObjectType>: NSObject

-(ObjectType _Nullable)parseRequestResult:(id _Nullable)requestResult;
-(RequestPath)urlPath;
-(REQUEST_METHOD)method;
-(NSString* _Nonnull)pathAsString;
-(NSDictionary* _Nullable)dataForPOST;

@end
