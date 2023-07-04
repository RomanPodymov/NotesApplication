//
//  RPNoteEditViewController.h
//  NotesApplication
//
//  Created by Roman Podymov on 04/07/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import UIKit;
#import "RPBaseViewController.h"
#import "RPNote.h"
#import "RPSettable.h"

@interface RPNoteEditViewController: RPBaseViewController

@property (nullable, nonatomic, strong) RPNote* currentNote;

@end

@interface RPNoteEditViewController(RPSettableStuff) <RPSettable>

-(void)setupWithData:(id _Nullable)data;

@end
