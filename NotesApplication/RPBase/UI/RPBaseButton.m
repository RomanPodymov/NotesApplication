//
//  RPBaseButton.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPBaseButton.h"
#import "RPUtilities.h"

@implementation RPBaseButton

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

@end

@implementation RPBaseButton (RPInitializableStuff)

-(void)commonInit {
    [self observeLocaleChanges];
    [self customize];
}

@end

@implementation RPBaseButton (RPSettableStuff)

-(void)setupWithData:(id _Nullable)data {
    
}

@end

@implementation RPBaseButton (RPLocalizableStuff)

-(void)onLocaleChanged:(NSString *)nextLocale {
    
}

@end

@implementation RPBaseButton (RPCustomizableStuff)

-(void)customize {
    [self setupStyles];
}

@end

@implementation RPBaseButton (RPStyleableStuff)

-(void)setupStyles {
    self.backgroundColor = RPCustomization.sharedInstance.colors.colorLight;
}

@end
