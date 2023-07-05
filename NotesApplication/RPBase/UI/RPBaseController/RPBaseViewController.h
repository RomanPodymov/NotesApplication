//
//  RPBaseViewController.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import UIKit;
#import "RPNetworkDataProvider.h"
#import "RPPreferencesDataProvider.h"
#import "RPPromiseGenerator.h"
#import "RPLocalizationMaster.h"
#import "RPCustomization.h"
#import "RPSettable.h"

typedef NS_ENUM(NSUInteger, LOAD_DATA_STRATEGY) {
    ON_VIEW_DID_LOAD,
    ON_VIEW_WILL_APPEAR
};

typedef NS_ENUM(NSUInteger, CONTROLLER_MODE) {
    CONTROLLER_MODE_WATCH,
    CONTROLLER_MODE_ADD,
    CONTROLLER_MODE_EDIT,
    CONTROLLER_MODE_DELETE,
    CONTROLLER_MODE_UNKNOWN
};

@interface RPBaseViewController: UIViewController

@property (nonnull, nonatomic, strong, readonly) RPNetworkDataProvider* networkDataProvider;
@property (nonnull, nonatomic, strong, readonly) RPPromiseGenerator* networkDataPromiseGenerator;
@property (nonnull, nonatomic, strong, readonly) RPPreferencesDataProvider* preferencesDataProvider;
@property (nonnull, nonatomic, strong, readonly) RPPromiseGenerator* preferencesDataPromiseGenerator;
@property (nonatomic) CONTROLLER_MODE controllerMode;

#pragma mark Custom methods
-(void)addSubviews;
-(void)setupConstraints;
-(void)onControllerModeChanged;
#pragma mark Bar customization
-(NSString* _Nullable)textForLeftBarItem;
-(NSString* _Nullable)textForRightBarItem;
#pragma mark UITableView specific
-(NSArray<NSNumber*>* _Nonnull)tableViewTags;
-(NSArray<Class>* _Nonnull)cellClasses;
-(NSArray<NSString*>* _Nonnull)cellIDs;
-(NSArray<NSNumber*>* _Nonnull)refreshControlsTags;
#pragma mark Data initialization
-(LOAD_DATA_STRATEGY)loadDataStrategy;
-(AnyPromise* _Nonnull)promiseToLoadData;

@end

@interface RPBaseViewController(RPLocalizableStuff) <RPLocalizable>

@end

@interface RPBaseViewController(RPCustomizableStuff) <RPCustomizable>

@end

@interface RPBaseViewController(RPStyleableStuff) <RPStyleable>

@end
