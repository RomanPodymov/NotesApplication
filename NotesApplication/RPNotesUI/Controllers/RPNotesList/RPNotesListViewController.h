//
//  RPNotesListViewController.h
//  NotesApplication
//
//  Created by Roman Podymov on 04/07/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import UIKit;
#import "RPBaseViewController.h"

#define TABLE_VIEW_ACCESS_LABEL @"Notes table view"

@interface RPNotesListViewController: RPBaseViewController

@property (nullable, nonatomic, strong) RPNotesList *notes;

-(void)onDataLoaded:(id _Nullable)data;

@end

@interface RPNotesListViewController (UITableViewDataSourceMethods) <UITableViewDataSource>

@end

@interface RPNotesListViewController (UITableViewDelegateMethods) <UITableViewDelegate>

@end

@interface RPNotesListViewController (UITableViewPrefetchingMethods) <UITableViewDataSourcePrefetching>

@end
