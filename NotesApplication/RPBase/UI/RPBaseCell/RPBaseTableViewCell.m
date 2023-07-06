//
//  RPBaseTableViewCell.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPBaseTableViewCell.h"

@implementation RPBaseTableViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

@end

@implementation RPBaseTableViewCell (RPInitializableStuff)

-(void)commonInit {
    [self observeLocaleChanges];
    [self customize];
}

@end

@implementation RPBaseTableViewCell (RPSettableStuff)

-(void)setupWithData:(id _Nullable)data {
    
}

@end

@implementation RPBaseTableViewCell (RPLocalizableStuff)

-(void)onLocaleChanged:(NSString *)nextLocale {
    
}

@end

@implementation RPBaseTableViewCell (RPCustomizableStuff)

-(void)customize {
    [self setupStyles];
}

@end

@implementation RPBaseTableViewCell (RPStyleableStuff)

-(void)setupStyles {
    self.backgroundColor = RPCustomization.sharedInstance.colors.colorLight;
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}

@end
