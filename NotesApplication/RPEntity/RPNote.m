//
//  RPNote.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPNote.h"

NSInteger const UNDEFINED_ID = 0;

@implementation RPNote

-(instancetype)initWithId:(NOTE_ID)idValue title:(NOTE_NAME* _Nonnull)title {
    self = [super init];
    if (self) {
        self.idValue = idValue;
        self.title = title;
    }
    return self;
}

-(instancetype)initWithId:(NOTE_ID)idValue {
    return [self initWithId:idValue title:[NSString string]];
}

-(instancetype)initWithTitle:(NOTE_NAME* _Nonnull)title {
    return [self initWithId:UNDEFINED_ID title:title];
}

-(RPNote* _Nonnull)withUpdatedTitle:(NSString* _Nonnull)title {
    return [[RPNote alloc] initWithId:_idValue title:title];
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        OBJECT_KEY_ID: JSON_KEY_ID,
        OBJECT_KEY_TITLE: JSON_KEY_TITLE,
    }];
}

@end
