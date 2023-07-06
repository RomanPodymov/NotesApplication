//
//  NotesApplicationTests.m
//  NotesApplicationTests
//
//  Created by Roman Podymov on 05/07/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import XCTest;
@import BlocksKit;
@import OCMock;
#import "RPPromiseGenerator.h"
#import "RPNetworkDataProvider.h"
#import "RPLocalizationMaster.h"
#import "RPNote.h"

NSTimeInterval const REQUEST_TIMEOUT = 60.0;
NSString* const REQUEST_EXPECTATION_DESCRIPTION = @"Waiting for promise to complete";
typedef void(^InvocationBlock)(NSInvocation*);

@interface NotesApplicationTests: XCTestCase

@end

@implementation NotesApplicationTests

- (void)testNoteInitializationWithIdAndTitle {
    NOTE_ID randomId = arc4random_uniform(INT_MAX - 1);
    NOTE_NAME* randomTitle = [NSUUID UUID].UUIDString;
    RPNote* noteWithIdAndTitile = [[RPNote alloc] initWithId:randomId title:randomTitle];
    XCTAssertEqual(noteWithIdAndTitile.idValue, randomId);
    XCTAssertTrue([noteWithIdAndTitile.title isEqualToString:randomTitle]);
}

- (void)testNoteInitializationWithId {
    NOTE_ID randomId = arc4random_uniform(INT_MAX - 1);
    RPNote* noteWithIdAndTitile = [[RPNote alloc] initWithId:randomId];
    XCTAssertEqual(noteWithIdAndTitile.idValue, randomId);
    XCTAssertTrue([noteWithIdAndTitile.title isEqualToString:[NSString string]]);
}

- (void)testNoteInitializationWithTitle {
    NOTE_NAME* randomTitle = [NSUUID UUID].UUIDString;
    RPNote* noteWithIdAndTitile = [[RPNote alloc] initWithTitle:randomTitle];
    XCTAssertEqual(noteWithIdAndTitile.idValue, UNDEFINED_ID);
    XCTAssertTrue([noteWithIdAndTitile.title isEqualToString:randomTitle]);
}

-(void)testTranslations {
    NSArray<NSString*>* notTranslatedKeys = [ALL_TRANSLATION_KEYS bk_select:^BOOL(NSString* currentTranslationKey) {
        return [[RPLocalizationMaster.sharedInstance translate:currentTranslationKey] isEqualToString:[NSString new]];
    }];
    XCTAssertTrue(notTranslatedKeys.isEmpty);
}

-(void)testPromiseToGetAllNotes {
    XCTestExpectation *expectation = [self expectationWithDescription:REQUEST_EXPECTATION_DESCRIPTION];
    id mockNetworkDataProvider = OCMClassMock([RPNetworkDataProvider class]);
    [[[mockNetworkDataProvider stub] andDo:^(NSInvocation *invocation) {
        void (^loadingCompletedBlock)(RPNotesList* _Nullable, NSError* _Nullable);
        [invocation getArgument:&loadingCompletedBlock atIndex:2];
        loadingCompletedBlock(@[], nil);
    }] loadNotesListWithHandler:[OCMArg any]];
    RPPromiseGenerator* promiseGenerator = [[RPPromiseGenerator alloc] initWithDataProvider:mockNetworkDataProvider];
    [promiseGenerator promiseToGetAllNotes].thenOn(dispatch_get_main_queue(), ^(id responseData){
        XCTAssertTrue(responseData != nil);
        [expectation fulfill];
    }).catchOn(dispatch_get_main_queue(), ^(NSError* loadDataError){
        XCTAssertTrue(loadDataError != nil);
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:REQUEST_TIMEOUT handler:^(NSError *error) {
        XCTAssertTrue(error == nil);
    }];
}

-(void)testPromiseToGetNoteForId {
    NOTE_ID nodeIdToTest = 10;
    XCTestExpectation *expectation = [self expectationWithDescription:REQUEST_EXPECTATION_DESCRIPTION];
    id mockNetworkDataProvider = OCMClassMock([RPNetworkDataProvider class]);
    [[[mockNetworkDataProvider stub] andDo:^(NSInvocation *invocation) {
        NOTE_ID noteIdFromInvocation;
        void (^loadingCompletedBlock)(RPNote* _Nullable, NSError* _Nullable);
        [invocation getArgument:&noteIdFromInvocation atIndex:2];
        [invocation getArgument:&loadingCompletedBlock atIndex:3];
        loadingCompletedBlock([[RPNote alloc] initWithId:noteIdFromInvocation], nil);
    }] loadNoteWithID:nodeIdToTest handler:[OCMArg any]];
    RPPromiseGenerator* promiseGenerator = [[RPPromiseGenerator alloc] initWithDataProvider:mockNetworkDataProvider];
    [promiseGenerator promiseToGetNoteForID:nodeIdToTest].thenOn(dispatch_get_main_queue(), ^(id responseData){
        XCTAssertTrue(responseData != nil);
        XCTAssertTrue([responseData isKindOfClass:[RPNote class]]);
        XCTAssertEqual(((RPNote*)responseData).idValue, nodeIdToTest);
        [expectation fulfill];
    }).catchOn(dispatch_get_main_queue(), ^(NSError* loadDataError){
        XCTAssertTrue(loadDataError != nil);
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:REQUEST_TIMEOUT handler:^(NSError *error) {
        XCTAssertTrue(error == nil);
    }];
}

@end

