//
//  RPLanguagesViewController.m
//  NotesApplication
//
//  Created by Roman Podymov on 04/07/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPLanguagesViewController.h"
#import "RPCustomization.h"
#import "RPLocaleButton.h"
@import BlocksKit;
@import PureLayout;

@interface RPLanguagesViewController ()

@property (nullable, nonatomic, strong, readonly) UIStackView* localesStackView;

@end

@implementation RPLanguagesViewController

#pragma mark UIKit methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateViewConstraints {
    NSNumber* localesStackViewTopOffset = RPCustomization.sharedInstance.langsGeometry.buttonsTopOffset;
    UIEdgeInsets localesStackViewInsets = UIEdgeInsetsMake(localesStackViewTopOffset.floatValue, 0.0, 0.0, 0.0);
    if (@available(iOS 11.0, *)) {
        [self.localesStackView autoPinEdgesToSuperviewSafeAreaWithInsets:localesStackViewInsets];
    } else {
        [self.localesStackView autoPinEdgesToSuperviewEdgesWithInsets:localesStackViewInsets];
    }
    [super updateViewConstraints];
}

- (IBAction)onBackBarButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark Bar customization

-(NSString* _Nullable)textForLeftBarItem {
    return [RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_BAR_BACK];
}

-(NSString* _Nullable)textForRightBarItem {
    return nil;
}

#pragma mark Data initialization

-(LOAD_DATA_STRATEGY)loadDataStrategy {
    return ON_VIEW_DID_LOAD;
}

-(AnyPromise* _Nonnull)promiseToLoadData {
    return [self.preferencesDataPromiseGenerator promiseToGetAllLocales];
}

-(void)onDataLoaded:(id _Nullable)data {
    [self createButtonsWithLocales:data];
}

-(void)onDataLoadingError:(NSError* _Nonnull)error {
    [self clearLocaleButtons];
}

#pragma mark UI

-(void)createButtonsWithLocales:(RPLocalesList*)locales {
    [self clearLocaleButtons];
    NSArray<UIView*>* stackViewButtons = [self createButtons:locales];
    NSArray<UIView*>* stackViewSubviews = [stackViewButtons arrayByAddingObject:[self createBottomView]];
    _localesStackView = [[UIStackView alloc] initWithArrangedSubviews:stackViewSubviews];
    _localesStackView.distribution = UIStackViewDistributionFill;
    _localesStackView.axis = UILayoutConstraintAxisVertical;
    _localesStackView.alignment = UIStackViewAlignmentCenter;
    _localesStackView.spacing = RPCustomization.sharedInstance.langsGeometry.buttonsSpace.floatValue;
    [self.view addSubview:_localesStackView];
}

-(void)clearLocaleButtons {
    /*[_localesStackView bk_eachSubview:^(UIView *subview) {
        [subview removeFromSuperview];
    }];*/
    [_localesStackView removeFromSuperview];
    _localesStackView = nil;
}

-(NSArray<UIView*>* _Nonnull)createButtons:(RPLocalesList*)locales {
    return [locales bk_map:^UIButton*(RPLocale* currentLocale) {
        RPLocaleButton* localeButton = [[RPLocaleButton alloc] initWithFrame:CGRectZero];
        [localeButton setupWithData:currentLocale];
        [localeButton setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
        [localeButton.heightAnchor constraintEqualToConstant:RPCustomization.sharedInstance.langsGeometry.buttonsHeight.floatValue].active = YES;
        [localeButton.widthAnchor constraintEqualToConstant:RPCustomization.sharedInstance.langsGeometry.buttonsWidth.floatValue].active = YES;
        return localeButton;
    }];
}

-(UIView* _Nonnull)createBottomView {
    UIView* result = [[UIView alloc] initWithFrame:CGRectZero];
    result.backgroundColor = UIColor.clearColor;
    [result setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    return result;
}

#pragma mark Localizable

-(void)onLocaleChanged:(NSString *)nextLocale {
    [super onLocaleChanged:nextLocale];
}

#pragma mark Styleable

-(void)setupStyles {
    [super setupStyles];
}

@end
