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
#import "RPNoteEditNavigationController.h"
#import "RPNotesListTableViewCell.h"

NSInteger const TAG_NOTES_TABLE_VIEW = 1000;
NSString* const NOTES_CELL_ID = @"NOTES_CELL_ID";
NSInteger const TAG_NOTES_REFRESH_CONTROL = 1010;

NSString* const TABLE_VIEW_ACCESS_LABEL = @"Notes table view";

NSString* const segueShowNoteAdd = @"showNoteAdd";
NSString* const segueShowNoteEdit = @"showNoteEdit";
NSString* const segueShowLanguages = @"showLanguages";

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
    _notesTableView.accessibilityLabel = TABLE_VIEW_ACCESS_LABEL;
    _notesTableView = notesTableView;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:segueShowNoteAdd] ||
        [segue.identifier isEqualToString:segueShowNoteEdit]) {
        if ([segue.destinationViewController isKindOfClass:[RPNoteEditNavigationController class]]) {
            [self prepareNoteEditController:segue.destinationViewController
                                       note:[RPNotesListViewController noteFromSender:sender]
                             controllerMode:[RPNotesListViewController controllerModeForSegue:segue.identifier]];
        }
    } else if ([segue.identifier isEqualToString:segueShowLanguages]) {

    }
}

+ (RPNote* _Nullable)noteFromSender:(id)sender {
    if ([sender isKindOfClass:[RPNote class]]) {
        return sender;
    }
    return nil;
}

+ (CONTROLLER_MODE)controllerModeForSegue:(NSString* const)segueName {
    if ([segueName isEqualToString:segueShowNoteAdd]) {
        return CONTROLLER_MODE_ADD;
    } else if ([segueName isEqualToString:segueShowNoteEdit]) {
        return CONTROLLER_MODE_WATCH;
    }
    return CONTROLLER_MODE_UNKNOWN;
}

- (void)prepareNoteEditController:(RPNoteEditNavigationController*)noteEditNavigationController
                             note:(RPNote*)note
                   controllerMode:(CONTROLLER_MODE)controllerMode {
    RPNoteEditViewController* noteEditController = noteEditNavigationController.viewControllers.firstObject;
    noteEditController.controllerMode = controllerMode;
    [noteEditController setupWithData:note];
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
    [self performSegueWithIdentifier:segueShowNoteEdit sender:[_notes objectAtIndex:indexPath.row]];
}

@end

@implementation RPNotesListViewController (UITableViewPrefetchingMethods)

- (void)tableView:(nonnull UITableView *)tableView prefetchRowsAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths {

}

@end
