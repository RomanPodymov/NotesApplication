//
//  RPNoteEditViewController.m
//  NotesApplication
//
//  Created by Roman Podymov on 04/07/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPNoteEditViewController.h"
#import "RPUtilities.h"
#import "RPLocalizationMaster.h"
#import "PureLayout.h"

typedef NS_ENUM(NSUInteger, NOTE_CONTROLLER_ERROR_CODE) {
    FAILED_ADD,
    FAILED_EDIT,
    FAILED_DELETE
};

typedef void(^NoteHandler)(id _Nullable);

@interface RPNoteEditViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textViewNote;

@end

@implementation RPNoteEditViewController

#pragma mark UIKit methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextViewNote];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateViewConstraints {
    NSNumber* textViewNoteTopOffset = RPCustomization.sharedInstance.noteEditGeometry.textViewTopOffset;
    NSNumber* textViewNoteLeftOffset = RPCustomization.sharedInstance.noteEditGeometry.textViewLeftOffset;
    NSNumber* textViewNoteBottomOffset = RPCustomization.sharedInstance.noteEditGeometry.textViewBottomOffset;
    NSNumber* textViewNoteRightOffset = RPCustomization.sharedInstance.noteEditGeometry.textViewRightOffset;
    [self.textViewNote autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(textViewNoteTopOffset.floatValue,
                                                                               textViewNoteLeftOffset.floatValue,
                                                                               textViewNoteBottomOffset.floatValue,
                                                                               textViewNoteRightOffset.floatValue)];
    [super updateViewConstraints];
}

- (IBAction)onBackBarButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

- (IBAction)onRightBarButtonPressed:(id)sender {
    switch (self.controllerMode) {
        case CONTROLLER_MODE_ADD:
            [self addNewNote];
            break;
        case CONTROLLER_MODE_EDIT:
            [self saveNote];
            break;
        case CONTROLLER_MODE_WATCH:
            [self showMoreVariants];
            break;
        case CONTROLLER_MODE_DELETE:
            break;
        case CONTROLLER_MODE_UNKNOWN:
            break;
    }
}

-(void)showMoreVariants {
    [self showItemsList:@[
        [[RPListItemParams alloc] initWithTitle:[RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_BTN_EDIT] handler:^{
            [self editNote];
        }],
        [[RPListItemParams alloc] initWithTitle:[RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_BTN_DELETE] handler:^{
            [self deleteNote];
        }]
    ]];
}

-(void)onControllerModeChanged {
    [super onControllerModeChanged];
    [self setupTextViewNote];
}

-(void)setupTextViewNote {
    switch (self.controllerMode) {
        case CONTROLLER_MODE_ADD:
        case CONTROLLER_MODE_EDIT:
            self.textViewNote.editable = true;
            break;
        case CONTROLLER_MODE_WATCH:
        case CONTROLLER_MODE_DELETE:
        case CONTROLLER_MODE_UNKNOWN:
            self.textViewNote.editable = false;
            break;
    }
}

-(void)makeActionOnNoteWithPromise:(AnyPromise* _Nonnull)promise
                         onSuccess:(NoteHandler)onSuccess
                         errorCode:(NOTE_CONTROLLER_ERROR_CODE)errorCode {
    [RPLoaderIndicator show];
    __weak RPNoteEditViewController* weakSelf = self;
    promise.thenOn(dispatch_get_main_queue(), ^(id _Nullable responseData){
        onSuccess(responseData);
    }).catchOn(dispatch_get_main_queue(), ^(NSError* loadDataError){
        RPNoteEditViewController* strongSelf = weakSelf;
        [strongSelf showErrorMessage:errorCode];
    }).ensureOn(dispatch_get_main_queue(), ^(){
        [RPLoaderIndicator hide];
    });
}

-(void)addNewNote {
    __weak RPNoteEditViewController* weakSelf = self;
    AnyPromise* promise = [self.networkDataPromiseGenerator promiseToAddNote:[[RPNote alloc] initWithTitle:self.textViewNote.text]];
    [self makeActionOnNoteWithPromise:promise
                            onSuccess:^(id _Nullable responseData) {
        if ([responseData isKindOfClass:[RPNote class]]) {
            RPNoteEditViewController* strongSelf = weakSelf;
            [strongSelf handleAddNoteSuccess];
        } else {
            RPNoteEditViewController* strongSelf = weakSelf;
            [strongSelf showErrorMessage:FAILED_ADD];
        }
    } errorCode:FAILED_ADD];
}

-(void)deleteNote {
    __weak RPNoteEditViewController* weakSelf = self;
    AnyPromise* promise = [self.networkDataPromiseGenerator promiseToDeleteNote:_currentNote];
    [self makeActionOnNoteWithPromise:promise
                            onSuccess:^(id _Nullable responseData) {
        RPNoteEditViewController* strongSelf = weakSelf;
        [strongSelf handleDeleteNoteSuccess];
    } errorCode:FAILED_DELETE];
}

-(void)editNote {
    self.controllerMode = CONTROLLER_MODE_EDIT;
}

-(void)saveNote {
    __weak RPNoteEditViewController* weakSelf = self;
    AnyPromise* promise = [self.networkDataPromiseGenerator promiseToEditNote:[_currentNote withUpdatedTitle:self.textViewNote.text]];
    [self makeActionOnNoteWithPromise:promise
                            onSuccess:^(id _Nullable responseData) {
        RPNoteEditViewController* strongSelf = weakSelf;
        [strongSelf handleEditNoteSuccess];
    } errorCode:FAILED_EDIT];
}

-(void)handleAddNoteSuccess {
    [self handleSuccess:[RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_ADD_NOTE_OK]];
}

-(void)handleEditNoteSuccess {
    [self handleSuccess:[RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_EDIT_NOTE_OK]];
}

-(void)handleDeleteNoteSuccess {
    [self handleSuccess:[RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_DELETE_NOTE_OK]];
}

-(void)handleSuccess:(NSString* _Nonnull)message {
    [self showMessageWithTitle:[RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_MESSAGE]
                   messageText:message
                       handler:^{
        [self dismissViewControllerAnimated:YES completion:^{
                               
        }];
    }];
}

-(void)showErrorMessage:(NOTE_CONTROLLER_ERROR_CODE)errorCode {
    [self showMessageWithTitle:[RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_ERROR]
                   messageText:[RPNoteEditViewController errorCodeToString:errorCode]
                       handler:^{

    }];
}

+(NSString* _Nonnull)errorCodeToString:(NOTE_CONTROLLER_ERROR_CODE)errorCode {
    switch (errorCode) {
        case FAILED_ADD:
            return [RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_CANNOT_ADD_NOTE];
        case FAILED_EDIT:
            return [RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_CANNOT_EDIT_NOTE];
        case FAILED_DELETE:
            return [RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_CANNOT_DELETE_NOTE];
    }
}

#pragma mark Bar customization

-(NSString* _Nullable)textForLeftBarItem {
    return [RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_BAR_BACK];
}

-(NSString* _Nullable)textForRightBarItem {
    switch (self.controllerMode) {
        case CONTROLLER_MODE_ADD:
            return [RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_BAR_SAVE];
        case CONTROLLER_MODE_EDIT:
            return [RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_BAR_SAVE];
        case CONTROLLER_MODE_WATCH:
            return [RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_BAR_MORE];
        case CONTROLLER_MODE_DELETE:
            return nil;
        case CONTROLLER_MODE_UNKNOWN:
            return nil;
    }
}

#pragma mark Data initialization

-(LOAD_DATA_STRATEGY)loadDataStrategy {
    return ON_VIEW_WILL_APPEAR;
}

-(AnyPromise* _Nonnull)promiseToLoadData {
    return [self.networkDataPromiseGenerator promiseToGetNoteForID:_currentNote.idValue];
}

-(void)onDataLoaded:(id _Nullable)data {
    [self setupWithData:data];
}

-(void)onDataLoadingError:(NSError* _Nonnull)error {
    
}

#pragma mark Localizable

-(void)onLocaleChanged:(NSString *)nextLocale {
    [super onLocaleChanged:nextLocale];
}

@end

@implementation RPNoteEditViewController(RPSettableStuff)

-(void)setupWithData:(id _Nullable)data {
    if (data != nil) {
        if ([data isKindOfClass:[NSArray<RPNote*> class]]) {
            if (!((NSArray<RPNote*>*)data).isEmpty) {
                _currentNote = [((NSArray<RPNote*>*)data) objectAtIndex:0];
            }
        } else if ([data isKindOfClass:[RPNote class]]) {
            _currentNote = data;
        }
        self.textViewNote.text = _currentNote.title;
    }
}

@end
