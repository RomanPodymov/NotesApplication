//
//  RPCustomization.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPCustomization.h"
@import UIColor_Hex;

NSString* const CUSTOMIZATION_FILE_NAME = @"Customization";
NSString* const CUSTOMIZATION_FILE_EXTENSION = @"plist";

NSString* const CUSTOM_KEY_NETWORK_DATA_SOURCE = @"NetworkDataSource";
NSString* const CUSTOM_KEY_HOST = @"Host";
NSString* const CUSTOM_KEY_SCHEME = @"Scheme";

NSString* const CUSTOM_KEY_LEFT = @"left";
NSString* const CUSTOM_KEY_TOP = @"top";
NSString* const CUSTOM_KEY_RIGHT = @"right";
NSString* const CUSTOM_KEY_BOTTOM = @"bottom";
NSString* const CUSTOM_KEY_HEIGHT = @"height";
NSString* const CUSTOM_KEY_GEOMETRY = @"Geometry";
    NSString* const CUSTOM_KEY_LANGUAGES_CONTROLLER = @"LanguagesController";
        NSString* const CUSTOM_KEY_BUTTONS_TOP_OFFSET = @"ButtonsTopOffset";
        NSString* const CUSTOM_KEY_BUTTONS_WIDTH = @"ButtonsWidth";
        NSString* const CUSTOM_KEY_BUTTONS_HEIGHT = @"ButtonsHeight";
        NSString* const CUSTOM_KEY_BUTTONS_SPACE = @"ButtonsSpace";
        NSString* const CUSTOM_KEY_BUTTONS_CHECK_WIDTH = @"ButtonsCheckMarkWidth";
        NSString* const CUSTOM_KEY_BUTTONS_CHECK_HEIGHT = @"ButtonsCheckMarkHeight";
        NSString* const CUSTOM_KEY_BUTTONS_CHECK_LEFT_OFFSET = @"ButtonsCheckMarkLeftOffset";
        NSString* const CUSTOM_KEY_BUTTONS_CHECK_RIGHT_OFFSET = @"ButtonsCheckMarkRightOffset";
    NSString* const CUSTOM_KEY_NOTES_CONTROLLER = @"NotesController";
        NSString* const CUSTOM_KEY_NOTES_CELL_INSET = @"NotesCellInset";
            NSString* const CUSTOM_KEY_NOTES_CELL_INSET_LEFT = CUSTOM_KEY_LEFT;
            NSString* const CUSTOM_KEY_NOTES_CELL_INSET_TOP = CUSTOM_KEY_TOP;
            NSString* const CUSTOM_KEY_NOTES_CELL_INSET_RIGHT = CUSTOM_KEY_RIGHT;
            NSString* const CUSTOM_KEY_NOTES_CELL_INSET_BOTTOM = CUSTOM_KEY_BOTTOM;
        NSString* const CUSTOM_KEY_NOTES_MESSAGE = @"Message";
            NSString* const CUSTOM_KEY_NOTES_MESSAGE_HEIGHT = CUSTOM_KEY_HEIGHT;
    NSString* const CUSTOM_KEY_EDIT_NOTE_CONTROLLER = @"NoteEditController";
        NSString* const CUSTOM_KEY_EDIT_NOTE_TEXT_VIEW_INSET = @"TextViewInset";
            NSString* const CUSTOM_KEY_EDIT_NOTE_CELL_INSET_LEFT = CUSTOM_KEY_LEFT;
            NSString* const CUSTOM_KEY_EDIT_NOTE_CELL_INSET_TOP = CUSTOM_KEY_TOP;
            NSString* const CUSTOM_KEY_EDIT_NOTE_CELL_INSET_RIGHT = CUSTOM_KEY_RIGHT;
            NSString* const CUSTOM_KEY_EDIT_NOTE_CELL_INSET_BOTTOM = CUSTOM_KEY_BOTTOM;

NSString* const CUSTOM_KEY_COLORS = @"Colors";
    NSString* const CUSTOM_KEY_COLOR_VERY_LIGHT = @"VeryLight";
    NSString* const CUSTOM_KEY_COLOR_LIGHT = @"Light";
    NSString* const CUSTOM_KEY_COLOR_MEDIUM = @"Medium";
    NSString* const CUSTOM_KEY_COLOR_DARK = @"Dark";
    NSString* const CUSTOM_KEY_COLOR_VERY_DARK = @"VeryDark";

@implementation RPCustomization

MAKE_SHARED(RPCustomization)

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *pathOfPlist = [[NSBundle mainBundle] pathForResource:CUSTOMIZATION_FILE_NAME
                                                                ofType:CUSTOMIZATION_FILE_EXTENSION];
        NSDictionary *rootDict = [[NSDictionary alloc] initWithContentsOfFile:pathOfPlist];
        NSDictionary *networkDataSource = [rootDict objectForKey:CUSTOM_KEY_NETWORK_DATA_SOURCE];
        _networkDataSource = [[RPCustomizationNetworkDataSource alloc] initWithHost:[networkDataSource objectForKey:CUSTOM_KEY_HOST] scheme:[networkDataSource objectForKey:CUSTOM_KEY_SCHEME]];
        
        NSDictionary *geometry = [rootDict objectForKey:CUSTOM_KEY_GEOMETRY];
        NSDictionary *geometryLanguages = [geometry objectForKey:CUSTOM_KEY_LANGUAGES_CONTROLLER];
        NSDictionary *geometryNotes = [geometry objectForKey:CUSTOM_KEY_NOTES_CONTROLLER];
        NSDictionary *geometryEditNote = [geometry objectForKey:CUSTOM_KEY_EDIT_NOTE_CONTROLLER];
        NSDictionary *appColors = [rootDict objectForKey:CUSTOM_KEY_COLORS];
        
        [self setupLanguagesControllerGeometry:geometryLanguages];
        [self setupNotesControllerGeometry:geometryNotes];
        [self setupEditNoteControllerGeometry:geometryEditNote];
        [self setupColors:appColors];
    }
    return self;
}

-(void)setupLanguagesControllerGeometry:(NSDictionary*)geometryLanguages {
    NSNumber* buttonsTopOffsetValue = [geometryLanguages objectForKey:CUSTOM_KEY_BUTTONS_TOP_OFFSET];
    NSNumber* buttonsWidthValue = [geometryLanguages objectForKey:CUSTOM_KEY_BUTTONS_WIDTH];
    NSNumber* buttonsHeightValue = [geometryLanguages objectForKey:CUSTOM_KEY_BUTTONS_HEIGHT];
    NSNumber* buttonsSpaceValue = [geometryLanguages objectForKey:CUSTOM_KEY_BUTTONS_SPACE];
    NSNumber* buttonsCheckWidth = [geometryLanguages objectForKey:CUSTOM_KEY_BUTTONS_CHECK_WIDTH];
    NSNumber* buttonsCheckHeight = [geometryLanguages objectForKey:CUSTOM_KEY_BUTTONS_CHECK_HEIGHT];
    NSNumber* buttonsCheckLeftOffset = [geometryLanguages objectForKey:CUSTOM_KEY_BUTTONS_CHECK_LEFT_OFFSET];
    NSNumber* buttonsCheckRightOffset = [geometryLanguages objectForKey:CUSTOM_KEY_BUTTONS_CHECK_RIGHT_OFFSET];
    _langsGeometry = [
        [RPCustomizationLanguagesControllerGeometry alloc] initWithButtonsTopOffset:buttonsTopOffsetValue
                        buttonsWidth:buttonsWidthValue
                       buttonsHeight:buttonsHeightValue
                        buttonsSpace:buttonsSpaceValue
               buttonsCheckmarkWidth:buttonsCheckWidth
              buttonsCheckmarkHeight:buttonsCheckHeight
          buttonsCheckmarkLeftOffset:buttonsCheckLeftOffset
         buttonsCheckmarkRightOffset:buttonsCheckRightOffset
    ];
}

-(void)setupNotesControllerGeometry:(NSDictionary*)geometryNotes {
    NSDictionary* geometryNotesCell = [geometryNotes objectForKey:CUSTOM_KEY_NOTES_CELL_INSET];
    NSNumber* notesCellInsetLeft = [geometryNotesCell objectForKey:CUSTOM_KEY_NOTES_CELL_INSET_LEFT];
    NSNumber* notesCellInsetTop = [geometryNotesCell objectForKey:CUSTOM_KEY_NOTES_CELL_INSET_TOP];
    NSNumber* notesCellInsetRight = [geometryNotesCell objectForKey:CUSTOM_KEY_NOTES_CELL_INSET_RIGHT];
    NSNumber* notesCellInsetBottom = [geometryNotesCell objectForKey:CUSTOM_KEY_NOTES_CELL_INSET_BOTTOM];
    NSDictionary* notesMessage = [geometryNotes objectForKey:CUSTOM_KEY_NOTES_MESSAGE];
    NSNumber* notesMessageHeight = [notesMessage objectForKey:CUSTOM_KEY_NOTES_MESSAGE_HEIGHT];
    _notesGeometry = [[RPNotesControllerGeometry alloc] initWithCellInsetLeft:notesCellInsetLeft
                                                                 cellInsetTop:notesCellInsetTop
                                                               cellInsetRight:notesCellInsetRight
                                                              cellInsetBottom:notesCellInsetBottom
                                                                messageHeight:notesMessageHeight];
}

-(void)setupEditNoteControllerGeometry:(NSDictionary*)geometryEditNote {
    NSDictionary* geometryEditNoteTextView = [geometryEditNote objectForKey:CUSTOM_KEY_EDIT_NOTE_TEXT_VIEW_INSET];
    NSNumber* textViewInsetLeft = [geometryEditNoteTextView objectForKey:CUSTOM_KEY_NOTES_CELL_INSET_LEFT];
    NSNumber* textViewInsetTop = [geometryEditNoteTextView objectForKey:CUSTOM_KEY_NOTES_CELL_INSET_TOP];
    NSNumber* textViewInsetRight = [geometryEditNoteTextView objectForKey:CUSTOM_KEY_NOTES_CELL_INSET_RIGHT];
    NSNumber* textViewInsetBottom = [geometryEditNoteTextView objectForKey:CUSTOM_KEY_NOTES_CELL_INSET_BOTTOM];
    _noteEditGeometry = [
        [RPCustomizationNoteEditControllerGeometry alloc] initWithTextViewLeftOffset:textViewInsetLeft
                     textViewTopOffset:textViewInsetTop
                   textViewRightOffset:textViewInsetRight
                  textViewBottomOffset:textViewInsetBottom
    ];
}

-(void)setupColors:(NSDictionary*)appColors {
    UIColor* colorVeryLight = [UIColor colorWithCSS:[appColors objectForKey:CUSTOM_KEY_COLOR_VERY_LIGHT]];
    UIColor* colorLight = [UIColor colorWithCSS:[appColors objectForKey:CUSTOM_KEY_COLOR_LIGHT]];
    UIColor* colorMedium = [UIColor colorWithCSS:[appColors objectForKey:CUSTOM_KEY_COLOR_MEDIUM]];
    UIColor* colorDark = [UIColor colorWithCSS:[appColors objectForKey:CUSTOM_KEY_COLOR_DARK]];
    UIColor* colorVeryDark = [UIColor colorWithCSS:[appColors objectForKey:CUSTOM_KEY_COLOR_VERY_DARK]];
    _colors = [[RPColors alloc] initWithColorVeryLight:colorVeryLight
                                            colorLight:colorLight
                                           colorMedium:colorMedium
                                             colorDark:colorDark
                                         colorVeryDark:colorVeryDark];
}

@end

@implementation RPCustomizationNetworkDataSource

- (instancetype)initWithHost:(CustomizationString)host scheme:(CustomizationString)scheme {
    self = [super init];
    if (self) {
        _host = host;
        _scheme = scheme;
    }
    return self;
}

@end

@implementation RPCustomizationLanguagesControllerGeometry

-(instancetype)initWithButtonsTopOffset:(CustomizationNumber)buttonsTopOffset
                           buttonsWidth:(CustomizationNumber)buttonsWidth
                          buttonsHeight:(CustomizationNumber)buttonsHeight
                           buttonsSpace:(CustomizationNumber)buttonsSpace
                  buttonsCheckmarkWidth:(CustomizationNumber)buttonsCheckmarkWidth
                 buttonsCheckmarkHeight:(CustomizationNumber)buttonsCheckmarkHeight
             buttonsCheckmarkLeftOffset:(CustomizationNumber)buttonsCheckmarkLeftOffset
            buttonsCheckmarkRightOffset:(CustomizationNumber)buttonsCheckmarkRightOffset {
    self = [super init];
    if (self) {
        _buttonsTopOffset = buttonsTopOffset;
        _buttonsWidth = buttonsWidth;
        _buttonsHeight = buttonsHeight;
        _buttonsSpace = buttonsSpace;
        _buttonsCheckmarkWidth = buttonsCheckmarkWidth;
        _buttonsCheckmarkHeight = buttonsCheckmarkHeight;
        _buttonsCheckmarkLeftOffset = buttonsCheckmarkLeftOffset;
        _buttonsCheckmarkRightOffset = buttonsCheckmarkRightOffset;
    }
    return self;
}

@end

@implementation RPNotesControllerGeometry

-(instancetype)initWithCellInsetLeft:(CustomizationNumber)cellInsetLeft
                        cellInsetTop:(CustomizationNumber)cellInsetTop
                      cellInsetRight:(CustomizationNumber)cellInsetRight
                     cellInsetBottom:(CustomizationNumber)cellInsetBottom
                       messageHeight:(CustomizationNumber)messageHeight {
    self = [super init];
    if (self) {
        _cellInsetLeft = cellInsetLeft;
        _cellInsetTop = cellInsetTop;
        _cellInsetRight = cellInsetRight;
        _cellInsetBottom = cellInsetBottom;
        _messageHeight = messageHeight;
    }
    return self;
}

@end

@implementation RPColors

-(instancetype)initWithColorVeryLight:(UIColor*)colorVeryLight
                           colorLight:(UIColor*)colorLight
                          colorMedium:(UIColor*)colorMedium
                            colorDark:(UIColor*)colorDark
                        colorVeryDark:(UIColor*)colorVeryDark {
    self = [super init];
    if (self) {
        _colorVeryLight = colorVeryLight;
        _colorLight = colorLight;
        _colorMedium = colorMedium;
        _colorDark = colorDark;
        _colorVeryDark = colorVeryDark;
    }
    return self;
}

@end

@implementation RPCustomizationNoteEditControllerGeometry

-(instancetype)initWithTextViewLeftOffset:(CustomizationNumber)textViewLeftOffset
                        textViewTopOffset:(CustomizationNumber)textViewTopOffset
                      textViewRightOffset:(CustomizationNumber)textViewRightOffset
                     textViewBottomOffset:(CustomizationNumber)textViewBottomOffset {
    self = [super init];
    if (self) {
        _textViewLeftOffset = textViewLeftOffset;
        _textViewTopOffset = textViewTopOffset;
        _textViewRightOffset = textViewRightOffset;
        _textViewBottomOffset = textViewBottomOffset;
    }
    return self;
}

@end
