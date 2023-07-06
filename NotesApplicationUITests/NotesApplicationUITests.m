//
//  NotesApplicationUITests.m
//  NotesApplicationUITests
//
//  Created by Roman Podymov on 06/07/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import XCTest;
#import "RPNotesListViewController.h"

@interface NotesApplicationUITests: XCTestCase

@property (nullable, nonatomic, strong) XCUIApplication* application;

@end

@implementation NotesApplicationUITests

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    _application = [[XCUIApplication alloc] init];
    [_application launch];
}

- (void)testTableView {
    XCUIElement* notesTableView = [[self.application.tables matchingIdentifier:TABLE_VIEW_ACCESS_LABEL] elementBoundByIndex:0];
    if ([notesTableView waitForExistenceWithTimeout:120.0]) {
        XCUIElement* firstCell = [notesTableView.cells elementBoundByIndex:0];
        if ([firstCell waitForExistenceWithTimeout:120.0]) {
            [firstCell tap];
        } else {
            XCTFail(@"Cells not found");
        }
    } else {
        XCTFail(@"Table view not found");
    }
}

@end
