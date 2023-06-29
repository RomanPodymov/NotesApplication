//
//  RPSettable.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;

@protocol RPInitializable

-(void)commonInit;

@end

@protocol RPSettable

-(void)setupWithData:(id _Nullable)data;

@end

@protocol RPStyleable

-(void)setupStyles;

@end
