//
//  RPBaseNavigationController.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import UIKit;
#import "RPLocalizationMaster.h"
#import "RPCustomization.h"
#import "RPSettable.h"

@interface RPBaseNavigationController : UINavigationController

@end

@interface RPBaseNavigationController(RPLocalizableStuff) <RPLocalizable>

@end

@interface RPBaseNavigationController(RPCustomizableStuff) <RPCustomizable>

@end

@interface RPBaseNavigationController(RPStyleableStuff) <RPStyleable>

@end
