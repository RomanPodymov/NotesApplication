//
//  RPBaseNotesRequest.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;
#import "RPBaseRequest.h"

extern NSString* const NOTES_PATH_BEGIN;

@interface RPBaseNotesRequest<__covariant ObjectType>: RPBaseRequest<ObjectType>

@end
