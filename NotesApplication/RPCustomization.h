//
//  RPCustomization.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;
#import "RPUtilities.h"

#define CUSTOMIZATION_PROPERTY @property (nullable, nonatomic, strong, readonly)

@class RPCustomizationNetworkDataSource;
@class RPCustomizationLanguagesControllerGeometry;
@class RPNotesControllerGeometry;
@class RPCustomizationNoteEditControllerGeometry;
@class RPColors;

typedef NSString* CustomizationString;
typedef NSNumber* CustomizationNumber;

@protocol RPCustomizable

-(void)customize;

@end

@interface RPCustomization : NSObject

SHARED_CLASS()

CUSTOMIZATION_PROPERTY RPCustomizationNetworkDataSource* networkDataSource;
CUSTOMIZATION_PROPERTY RPCustomizationLanguagesControllerGeometry* langsGeometry;
CUSTOMIZATION_PROPERTY RPNotesControllerGeometry* notesGeometry;
CUSTOMIZATION_PROPERTY RPCustomizationNoteEditControllerGeometry* noteEditGeometry;
CUSTOMIZATION_PROPERTY RPColors* colors;

@end

@interface RPCustomizationNetworkDataSource : NSObject

-(instancetype _Nullable)initWithHost:(CustomizationString _Nullable)host scheme:(CustomizationString _Nullable)scheme;
CUSTOMIZATION_PROPERTY CustomizationString host;
CUSTOMIZATION_PROPERTY CustomizationString scheme;

@end

@interface RPCustomizationLanguagesControllerGeometry : NSObject

-(instancetype _Nullable)initWithButtonsTopOffset:(CustomizationNumber _Nonnull)buttonsTopOffset
                                     buttonsWidth:(CustomizationNumber _Nonnull)buttonsWidth
                                    buttonsHeight:(CustomizationNumber _Nonnull)buttonsHeight
                                     buttonsSpace:(CustomizationNumber _Nonnull)buttonsSpace
                            buttonsCheckmarkWidth:(CustomizationNumber _Nonnull)buttonsCheckmarkWidth
                           buttonsCheckmarkHeight:(CustomizationNumber _Nonnull)buttonsCheckmarkHeight
                       buttonsCheckmarkLeftOffset:(CustomizationNumber _Nonnull)buttonsCheckmarkLeftOffset
                      buttonsCheckmarkRightOffset:(CustomizationNumber _Nonnull)buttonsCheckmarkRightOffset;
CUSTOMIZATION_PROPERTY CustomizationNumber buttonsTopOffset;
CUSTOMIZATION_PROPERTY CustomizationNumber buttonsWidth;
CUSTOMIZATION_PROPERTY CustomizationNumber buttonsHeight;
CUSTOMIZATION_PROPERTY CustomizationNumber buttonsSpace;
CUSTOMIZATION_PROPERTY CustomizationNumber buttonsCheckmarkWidth;
CUSTOMIZATION_PROPERTY CustomizationNumber buttonsCheckmarkHeight;
CUSTOMIZATION_PROPERTY CustomizationNumber buttonsCheckmarkLeftOffset;
CUSTOMIZATION_PROPERTY CustomizationNumber buttonsCheckmarkRightOffset;

@end

@interface RPNotesControllerGeometry : NSObject

-(instancetype _Nullable)initWithCellInsetLeft:(CustomizationNumber _Nonnull)cellInsetLeft
                                  cellInsetTop:(CustomizationNumber _Nonnull)cellInsetTop
                                cellInsetRight:(CustomizationNumber _Nonnull)cellInsetRight
                               cellInsetBottom:(CustomizationNumber _Nonnull)cellInsetBottom
                                 messageHeight:(CustomizationNumber _Nonnull)messageHeight;
CUSTOMIZATION_PROPERTY CustomizationNumber cellInsetLeft;
CUSTOMIZATION_PROPERTY CustomizationNumber cellInsetTop;
CUSTOMIZATION_PROPERTY CustomizationNumber cellInsetRight;
CUSTOMIZATION_PROPERTY CustomizationNumber cellInsetBottom;
CUSTOMIZATION_PROPERTY CustomizationNumber messageHeight;

@end

@interface RPColors : NSObject

-(instancetype _Nullable)initWithColorVeryLight:(UIColor* _Nonnull)colorVeryLight
                                     colorLight:(UIColor* _Nonnull)colorLight
                                    colorMedium:(UIColor* _Nonnull)colorMedium
                                      colorDark:(UIColor* _Nonnull)colorDark
                                  colorVeryDark:(UIColor* _Nonnull)colorVeryDark;
CUSTOMIZATION_PROPERTY UIColor* colorVeryLight;
CUSTOMIZATION_PROPERTY UIColor* colorLight;
CUSTOMIZATION_PROPERTY UIColor* colorMedium;
CUSTOMIZATION_PROPERTY UIColor* colorDark;
CUSTOMIZATION_PROPERTY UIColor* colorVeryDark;

@end

@interface RPCustomizationNoteEditControllerGeometry : NSObject

-(instancetype _Nullable)initWithTextViewLeftOffset:(CustomizationNumber _Nonnull)textViewLeftOffset
                                  textViewTopOffset:(CustomizationNumber _Nonnull)textViewTopOffset
                                textViewRightOffset:(CustomizationNumber _Nonnull)textViewRightOffset
                               textViewBottomOffset:(CustomizationNumber _Nonnull)textViewBottomOffset;
CUSTOMIZATION_PROPERTY CustomizationNumber textViewLeftOffset;
CUSTOMIZATION_PROPERTY CustomizationNumber textViewTopOffset;
CUSTOMIZATION_PROPERTY CustomizationNumber textViewRightOffset;
CUSTOMIZATION_PROPERTY CustomizationNumber textViewBottomOffset;

@end
