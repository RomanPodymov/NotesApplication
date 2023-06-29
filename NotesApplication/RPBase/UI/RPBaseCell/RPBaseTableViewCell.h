//
//  RPBaseTableViewCell.h
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

@interface RPBaseTableViewCell: UITableViewCell

@end

@interface RPBaseTableViewCell(RPSettableStuff) <RPSettable>

@end

@interface RPBaseTableViewCell(RPLocalizableStuff) <RPLocalizable>

@end

@interface RPBaseTableViewCell(RPCustomizableStuff) <RPCustomizable>

@end

@interface RPBaseTableViewCell(RPStyleableStuff) <RPStyleable>

@end
