//
//  RPBaseView.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import UIKit;
#import "RPSettable.h"
#import "RPLocalizationMaster.h"
#import "RPCustomization.h"

@interface RPBaseView: UIView

@end

@interface RPBaseView(RPInitializableStuff) <RPInitializable>

@end

@interface RPBaseView(RPLocalizableStuff) <RPLocalizable>

@end

@interface RPBaseView(RPCustomizableStuff) <RPCustomizable>

@end
