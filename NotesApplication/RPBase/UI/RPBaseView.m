//
//  RPBaseView.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPBaseView.h"

@implementation RPBaseView

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

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

@end

@implementation RPBaseView(RPInitializableStuff)

-(void)commonInit {
    [self observeLocaleChanges];
    [self customize];
}

@end

@implementation RPBaseView(RPLocalizableStuff)

-(void)onLocaleChanged:(NSString *)nextLocale {
    
}

@end

@implementation RPBaseView(RPCustomizableStuff)

-(void)customize {
    
}

@end
