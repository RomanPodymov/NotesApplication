//
//  RPBaseTableViewCell.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPBaseTableViewCell.h"

@implementation RPBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self customize];
    [self setNeedsUpdateConstraints];
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
