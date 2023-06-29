//
//  RPLocale.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPLocale.h"

@implementation RPLocale

-(instancetype)initWithLocaleID:(LOCALE_ID*)localeID localeTitle:(NSString*)localeTitle {
    self = [super init];
    if (self) {
        _localeID = localeID;
        _localeTitle = localeTitle;
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[RPLocale class]]) {
        return ((RPLocale*)object).localeID == _localeID;
    }
    return NO;
}

@end
