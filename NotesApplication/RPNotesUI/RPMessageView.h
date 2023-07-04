//
//  RPMessageView.h
//  NotesApplication
//
//  Created by Roman Podymov on 04/07/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import UIKit;
#import "RPBaseView.h"

@interface RPMessageView: RPBaseView

@property (nullable, nonatomic) NSString* messageText;
@property (nullable, nonatomic) NSString* messageTextTranslationKey;

@end
