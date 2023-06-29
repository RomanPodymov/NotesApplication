//
//  RPBaseCollectionViewCell.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import UIKit;
#import "RPLocalizationMaster.h"
#import "RPCustomization.h"

@interface RPBaseCollectionViewCell: UICollectionViewCell

@end

@interface RPBaseCollectionViewCell(RPLocalizableStuff) <RPLocalizable>

@end

@interface RPBaseCollectionViewCell(RPCustomizableStuff) <RPCustomizable>

@end
