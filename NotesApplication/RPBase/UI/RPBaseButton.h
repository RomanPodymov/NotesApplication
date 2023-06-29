//
//  RPBaseButton.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import UIKit;
#import "RPSettable.h"
#import "RPLocalizationMaster.h"
#import "RPCustomization.h"
#import "RPSettable.h"

@interface RPBaseButton: UIButton

@end

@interface RPBaseButton(RPInitializableStuff) <RPInitializable>

@end

@interface RPBaseButton(RPSettableStuff) <RPSettable>

@end

@interface RPBaseButton(RPLocalizableStuff) <RPLocalizable>

@end

@interface RPBaseButton(RPCustomizableStuff) <RPCustomizable>

@end

@interface RPBaseButton(RPStyleableStuff) <RPStyleable>

@end
