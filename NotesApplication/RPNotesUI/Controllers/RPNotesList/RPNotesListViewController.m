//
//  RPNotesListViewController.m
//  NotesApplication
//
//  Created by Roman Podymov on 04/07/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import PureLayout;
@import Hero;
#import "RPNotesListViewController.h"
#import "RPNetworkDataProvider.h"
#import "RPBaseTableViewCell.h"
#import "RPMessageView.h"
#import "RPUtilities.h"
#import "RPLocalizationMaster.h"
#import "RPCustomization.h"
#import "RPNoteEditViewController.h"
#import "RPNotesListTableViewCell.h"
#import "RPLanguagesViewController.h"

NSInteger const TAG_NOTES_TABLE_VIEW = 1000;
NSString* const NOTES_CELL_ID = @"NOTES_CELL_ID";
NSInteger const TAG_NOTES_REFRESH_CONTROL = 1010;

@interface RPNotesListViewController ()

@property (weak, nonatomic) UITableView *notesTableView;
@property (weak, nonatomic) RPMessageView *notesMessageView;

@end

@implementation RPNotesListViewController

#pragma mark Custom methods

- (void)addSubviews {
    [super addSubviews];
    UITableView *notesTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    notesTableView.tag = TAG_NOTES_TABLE_VIEW;
    notesTableView.delegate = self;
    notesTableView.dataSource = self;
    [self.view addSubview:notesTableView];
    notesTableView.accessibilityLabel = TABLE_VIEW_ACCESS_LABEL;
    _notesTableView = notesTableView;
    RPMessageView *notesMessageView = [[RPMessageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:notesMessageView];
    _notesMessageView = notesMessageView;
}

-(void)onLeftBarButtonItemTap {
    RPLanguagesViewController* languagesViewController = [RPLanguagesViewController new];
    [self.navigationController pushViewController:languagesViewController animated:YES];
}

-(void)onRightBarButtonItemTap {
    [self openEditScreen:CONTROLLER_MODE_ADD note:nil];
}

- (void)openEditScreen:(CONTROLLER_MODE)mode note:(RPNote* _Nullable)note {
    RPNoteEditViewController* noteEditViewController = [RPNoteEditViewController new];
    noteEditViewController.controllerMode = mode;
    [noteEditViewController setupWithData:note];
    [self.navigationController pushViewController:noteEditViewController animated:YES];
}

#pragma mark UIKit methods

- (void)setupConstraints {
    [super setupConstraints];
    UIEdgeInsets tableViewInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        [self.notesTableView autoPinEdgesToSuperviewSafeAreaWithInsets:tableViewInsets];
    } else {
        [self.notesTableView autoPinEdgesToSuperviewEdgesWithInsets:tableViewInsets];
    }
    [self.notesMessageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.notesTableView];
    [self.notesMessageView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.notesTableView];
    [self.notesMessageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
    [self.notesMessageView autoSetDimension:ALDimensionHeight toSize:RPCustomization.sharedInstance.notesGeometry.messageHeight.floatValue];
}

#pragma mark Bar customization

-(NSString* _Nullable)textForLeftBarItem {
    return [RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_BAR_LANGUAGES];
}

-(NSString* _Nullable)textForRightBarItem {
    return [RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_BAR_ADD];
}

#pragma mark UITableView specific

-(NSArray<NSNumber*>* _Nonnull)tableViewTags {
    return @[[NSNumber numberWithInteger:TAG_NOTES_TABLE_VIEW]];
}

-(NSArray<Class>* _Nonnull)cellClasses {
    return @[[RPNotesListTableViewCell class]];
}

-(NSArray<NSString*>* _Nonnull)cellIDs {
    return @[NOTES_CELL_ID];
}

-(NSArray<NSNumber*>* _Nonnull)refreshControlsTags {
    return @[[NSNumber numberWithInteger:TAG_NOTES_REFRESH_CONTROL]];
}

#pragma mark Data initialization

- (LOAD_DATA_STRATEGY)loadDataStrategy {
    return ON_VIEW_WILL_APPEAR;
}

-(AnyPromise* _Nonnull)promiseToLoadData {
    return [self.networkDataPromiseGenerator promiseToGetAllNotes];
}

-(void)onDataLoaded:(id _Nullable)data {
    self->_notes = data;
    [self.notesTableView reloadData];
    if (self->_notes == nil || self->_notes.isEmpty) {
        [self showMessage:TRANSLATION_KEY_EMPTY_DATA];
    } else {
        [self showMessage:nil];
    }
}

-(void)onDataLoadingError:(NSError* _Nonnull)error {
    [self showMessage:TRANSLATION_KEY_ERROR_GET_DATA];
}

-(void)showMessage:(NSString* _Nullable)messageTextKey {
    self.notesMessageView.hidden = messageTextKey == nil;
    self.notesMessageView.messageTextTranslationKey = messageTextKey;
}

#pragma mark Localizable

-(void)onLocaleChanged:(NSString *)nextLocale {
    [super onLocaleChanged:nextLocale];
}

#pragma mark Styleable

-(void)setupStyles {
    [super setupStyles];
    self.notesTableView.backgroundColor = self.view.backgroundColor;
}

@end

@implementation RPNotesListViewController (UITableViewDataSourceMethods)

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell* result = [tableView dequeueReusableCellWithIdentifier:NOTES_CELL_ID forIndexPath:indexPath];
    if ([result isKindOfClass:[RPBaseTableViewCell class]]) {
        [(RPBaseTableViewCell*)result setupWithData:_notes[indexPath.row]];
    }
    return result;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _notes.count;
}

@end

@implementation RPNotesListViewController (UITableViewDelegateMethods)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self openEditScreen:CONTROLLER_MODE_WATCH note:self.notes[indexPath.row]];
}

@end

@implementation RPNotesListViewController (UITableViewPrefetchingMethods)

- (void)tableView:(nonnull UITableView *)tableView prefetchRowsAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths {

}

@end
