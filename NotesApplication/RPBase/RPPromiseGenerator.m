//
//  RPPromiseGenerator.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPPromiseGenerator.h"

#define PROMISE_HANDLER ^(id _Nullable data, NSError* _Nullable error) { \
    [RPPromiseGenerator resolveResults:data \
                             withError:error \
                              resolver:resolver]; \
}

typedef void(^PromiseBlock)(PMKResolver);

@implementation RPPromiseGenerator

- (instancetype)initWithDataProvider:(id<RPDataProvider>)dataProvider {
    self = [super init];
    if (self) {
        _dataProvider = dataProvider;
    }
    return self;
}

-(AnyPromise* _Nonnull)genericPromise:(PromiseBlock)promiseBlock {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolver) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
            promiseBlock(resolver);
        });
    }];
}

-(AnyPromise* _Nonnull)promiseToGetAllNotes {
    return [self genericPromise:^(PMKResolver resolver) {
        [self->_dataProvider loadNotesListWithHandler:PROMISE_HANDLER];
    }];
}

-(AnyPromise* _Nonnull)promiseToGetNoteForID:(NOTE_ID)nodeID {
    return [self genericPromise:^(PMKResolver resolver) {
        [self->_dataProvider loadNoteWithID:nodeID handler:PROMISE_HANDLER];
    }];
}

-(AnyPromise* _Nonnull)promiseToAddNote:(RPNote* _Nonnull)note {
    return [self genericPromise:^(PMKResolver resolver) {
        [self->_dataProvider addNote:note handler:PROMISE_HANDLER];
    }];
}

-(AnyPromise* _Nonnull)promiseToEditNote:(RPNote* _Nonnull)note {
    return [self genericPromise:^(PMKResolver resolver) {
        [self->_dataProvider editNote:note handler:PROMISE_HANDLER];
    }];
}

-(AnyPromise* _Nonnull)promiseToDeleteNote:(RPNote* _Nonnull)note {
    return [self genericPromise:^(PMKResolver resolver) {
        [self->_dataProvider deleteNote:note handler:PROMISE_HANDLER];
    }];
}

-(AnyPromise* _Nonnull)promiseToGetAllLocales {
    return [self genericPromise:^(PMKResolver resolver) {
        [self->_dataProvider loadLocalesListWithHandler:PROMISE_HANDLER];
    }];
}

+(void)resolveResults:(id _Nullable)results withError:(NSError* _Nullable)error resolver:(PMKResolver)resolver {
    if (results != nil && error == nil) {
        resolver(results);
    } else if (results == nil && error != nil) {
        resolver(error);
    } else {
        resolver(nil);
    }
}

@end
