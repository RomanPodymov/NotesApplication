//
//  RPLocaleButton.m
//  NotesApplication
//
//  Created by Roman Podymov on 04/07/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPLocaleButton.h"
#import "RPLocale.h"
#import "RPUtilities.h"
#import "RPLocalizationMaster.h"
#import "RPPreferences.h"
#import "RPCustomization.h"

@interface RPLocaleButton ()

@property (nullable, nonatomic, strong, readonly) RPLocale* data;

@end

@implementation RPLocaleButton

-(void)commonInit {
    [super commonInit];
    [self addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventPrimaryActionTriggered];
    CGFloat imageEdgeLeftInset = RPCustomization.sharedInstance.langsGeometry.buttonsCheckmarkLeftOffset.floatValue;
    CGFloat imageEdgeRightInset = RPCustomization.sharedInstance.langsGeometry.buttonsCheckmarkRightOffset.floatValue;
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, imageEdgeLeftInset, 0.0, 0.0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, imageEdgeRightInset, 0.0, 0.0);
}

-(void)setupWithData:(id _Nullable)data {
    if ([data isKindOfClass:[RPLocale class]]) {
        RPLocale* localeData = (RPLocale*)data;
        _data = data;
        [self setTitle:localeData.localeTitle forState:UIControlStateNormal];
        [self setupStyles];
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
}

-(void)setupSelectedState:(BOOL)isSelected {
    UIColor* colorForCheckMark = isSelected ? RPCustomization.sharedInstance.colors.colorDark :
                                              RPCustomization.sharedInstance.colors.colorLight;
    CGRect checkMarkRect = CGRectMake(0.0,
                                      0.0,
                                      RPCustomization.sharedInstance.langsGeometry.buttonsCheckmarkWidth.floatValue,
                                      RPCustomization.sharedInstance.langsGeometry.buttonsCheckmarkHeight.floatValue);
    [self setImage:[UIImage imageFromColor:colorForCheckMark
                                  withRect:checkMarkRect]
                                  forState:UIControlStateNormal];
}

-(void)onBtnPressed:(UIButton*)btn {
    if ([btn isKindOfClass:[RPLocaleButton class]]) {
        RPLocaleButton* localeButton = (RPLocaleButton*)btn;
        [RPLocalizationMaster.sharedInstance setupCurrentLocaleID:localeButton.data.localeID];
    }
}

-(void)onLocaleChanged:(LOCALE_ID *)nextLocale {
    [super onLocaleChanged:nextLocale];
    [self setupSelectedState:[_data.localeID isEqualToString:nextLocale]];
}

@end

@implementation RPLocaleButton (RPStyleableStuff)

-(void)setupStyles {
    [super setupStyles];
    self.backgroundColor = RPCustomization.sharedInstance.colors.colorLight;
    [self setTitleColor:RPCustomization.sharedInstance.colors.colorVeryDark forState:UIControlStateNormal];
    [self setupSelectedState:[RPPreferences.sharedInstance.selectedLocale isEqualToString:_data.localeID]];
}

@end
