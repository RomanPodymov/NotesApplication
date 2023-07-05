//
//  RPBaseViewController.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPBaseViewController.h"
@import BlocksKit;

#define LOADER_HANDLER(METHOD_TO_CALL_WITH_DATA, RECEIVED_DATA) \
    RPBaseViewController* strongSelf = weakSelf; \
    [strongSelf METHOD_TO_CALL_WITH_DATA:RECEIVED_DATA]; \
    UIRefreshControl* strongRefreshControl = weakRefreshControl; \
    [strongRefreshControl endRefreshing];

@interface RPBaseViewController ()

@end

@implementation RPBaseViewController

@synthesize controllerMode = _controllerMode;

#pragma mark UIKit methods

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self observeLocaleChanges];
    [self setupStyles];
    [self setupBarAndCustomize];
    [self setupTableViews:[self tableViewTags] cellClasses:[self cellClasses] cellIDs:[self cellIDs]];
    [self setupTableViews:[self tableViewTags] refreshControlsTags:[self refreshControlsTags]];
    [self setupConstraints];
    const LOAD_DATA_STRATEGY loadDataStrategyValue = [self loadDataStrategy];
    if (loadDataStrategyValue == ON_VIEW_DID_LOAD) {
        [self loadData:nil];
    }
}

- (void)setupBarAndCustomize {
    [self customize];
    [self setupBar];
}

- (void)setupBar {
    NSString* textForLeftBarValue = [self textForLeftBarItem];
    if (textForLeftBarValue != nil) {
        self.navigationItem.leftBarButtonItem = [
            [UIBarButtonItem alloc] initWithTitle:textForLeftBarValue
                                            style:UIBarButtonItemStylePlain
                                           target:self
                                           action:@selector(onLeftBarButtonItemTap)
        ];
    }
    NSString* textForRightBarValue = [self textForRightBarItem];
    if (textForRightBarValue != nil) {
        self.navigationItem.rightBarButtonItem = [
            [UIBarButtonItem alloc] initWithTitle:textForRightBarValue
                                            style:UIBarButtonItemStylePlain
                                           target:self
                                           action:@selector(onRightBarButtonItemTap)
        ];
    }
}

-(void)onLeftBarButtonItemTap {
    
}

-(void)onRightBarButtonItemTap {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    const LOAD_DATA_STRATEGY loadDataStrategyValue = [self loadDataStrategy];
    if (loadDataStrategyValue == ON_VIEW_WILL_APPEAR) {
        [self loadData:nil];
    }
}

#pragma mark Custom methods

-(void)commonInit {
    _networkDataProvider = [RPNetworkDataProvider new];
    _networkDataPromiseGenerator = [[RPPromiseGenerator alloc] initWithDataProvider:_networkDataProvider];
    _preferencesDataProvider = [RPPreferencesDataProvider new];
    _preferencesDataPromiseGenerator = [[RPPromiseGenerator alloc] initWithDataProvider:_preferencesDataProvider];
}

-(void)addSubviews {
    
}

-(void)setupConstraints {
    
}

- (CONTROLLER_MODE)controllerMode {
    return _controllerMode;
}

- (void)setControllerMode:(CONTROLLER_MODE)controllerMode {
    _controllerMode = controllerMode;
    [self onControllerModeChanged];
}

- (void)onControllerModeChanged {
    [self setupBarAndCustomize];
}

#pragma mark Bar customization

-(NSString* _Nullable)textForLeftBarItem {
    return nil;
}

-(NSString* _Nullable)textForRightBarItem {
    return nil;
}

#pragma mark UITableView specific

-(NSArray<NSNumber*>* _Nonnull)tableViewTags {
    return @[];
}

-(NSArray<NSString*>* _Nonnull)cellClasses {
    return @[];
}

-(NSArray<NSString*>* _Nonnull)cellIDs {
    return @[];
}

-(NSArray<NSNumber*>* _Nonnull)refreshControlsTags {
    return @[];
}

-(void)setupTableViews:(NSArray<NSNumber*>*)tableViewTags
           cellClasses:(NSArray<Class>*)cellClasses
               cellIDs:(NSArray<NSString*>*)cellIDs {
    NSArray<NSNumber*>* arraysCount = @[
        [NSNumber numberWithUnsignedInteger:tableViewTags.count],
        [NSNumber numberWithUnsignedInteger:cellClasses.count],
        [NSNumber numberWithUnsignedInteger:cellIDs.count]
    ];
    id minArrayCount = [arraysCount valueForKeyPath:@"@min.unsignedIntegerValue"];
    if ([minArrayCount isKindOfClass:[NSNumber class]]) {
        for (NSUInteger i = 0; i < ((NSNumber*)minArrayCount).unsignedIntegerValue; ++i) {
            UITableView* tableViewForTag = [self.view viewWithTag:tableViewTags[i].integerValue];
            [tableViewForTag registerClass:cellClasses[i] forCellReuseIdentifier:cellIDs[i]];
        }
    }
}

-(void)setupTableViews:(NSArray<NSNumber*>*)tableViewTags
   refreshControlsTags:(NSArray<NSNumber*>*)refreshControlsTags {
    for (NSUInteger i = 0; i < MIN(tableViewTags.count, refreshControlsTags.count); ++i) {
        UIRefreshControl* refreshControl = [UIRefreshControl new];
        refreshControl.tag = refreshControlsTags[i].integerValue;
        [refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
        UITableView* tableViewForTag = [self.view viewWithTag:tableViewTags[i].integerValue];
        tableViewForTag.refreshControl = refreshControl;
    }
}

-(void)refreshTableView:(UIRefreshControl*)refreshControl {
    [self loadData:refreshControl];
}

#pragma mark Data initialization

-(LOAD_DATA_STRATEGY)loadDataStrategy {
    return ON_VIEW_DID_LOAD;
}

-(AnyPromise* _Nonnull)promiseToLoadData {
    return [AnyPromise promiseWithValue:nil];
}

-(void)loadData:(UIRefreshControl* _Nullable)refreshControl {
    __weak RPBaseViewController* weakSelf = self;
    __weak UIRefreshControl* weakRefreshControl = refreshControl;
    [self promiseToLoadData].thenOn(dispatch_get_main_queue(), ^(id responseData){
        LOADER_HANDLER(onDataLoaded, responseData)
    }).catchOn(dispatch_get_main_queue(), ^(NSError* loadDataError){
        LOADER_HANDLER(onDataLoadingError, loadDataError)
    });
}

-(void)onDataLoaded:(id _Nullable)data {
    
}

-(void)onDataLoadingError:(NSError* _Nonnull)error {
    
}

@end

@implementation RPBaseViewController (RPLocalizableStuff)

-(void)onLocaleChanged:(NSString *)nextLocale {
    [self setupBar];
}

@end

@implementation RPBaseViewController (RPCustomizableStuff)

-(void)customize {
    
}

@end

@implementation RPBaseViewController (RPStyleableStuff)

-(void)setupStyles {
    self.view.backgroundColor = RPCustomization.sharedInstance.colors.colorMedium;
    self.navigationController.navigationBar.tintColor = RPCustomization.sharedInstance.colors.colorDark;
}

@end
